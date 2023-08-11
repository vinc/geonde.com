# frozen_string_literal: true

# https://transparency.entsoe.eu/content/static_content/Static%20content/web%20api/Guide.html#_processtype

class EntsoeData
  include CarbonIntensity

  attr_reader :time

  INTERVALS = {
    "PT60M" => 60.minutes,
    "PT15M" => 15.minutes,
  }

  DOMAINS = {
    "se" => "10YSE-1--------K",
    "de" => "10Y1001A1001A83F",
    "es" => "10YES-REE------0",
    "fr" => "10YFR-RTE------C",
    "ch" => "10YCH-SWISSGRIDZ",
    "it" => "10YIT-GRTN-----B",
    #"ie" => "10YIE-1001A00010",
    "uk" => "10Y1001A1001A92E",
  }

  FUELS = {
    "B01" => "Biomass",
    "B02" => "Fossil Brown coal/Lignite",
    "B03" => "Fossil Coal-derived gas",
    "B04" => "Fossil Gas",
    "B05" => "Fossil Hard coal",
    "B06" => "Fossil Oil",
    "B07" => "Fossil Oil shale",
    "B08" => "Fossil Peat",
    "B09" => "Geothermal",
    "B10" => "Hydro Pumped Storage",
    "B11" => "Hydro Run-of-river and poundage",
    "B12" => "Hydro Water Reservoir",
    "B13" => "Marine",
    "B14" => "Nuclear",
    "B15" => "Other renewable",
    "B16" => "Solar",
    "B17" => "Waste",
    "B18" => "Wind Offshore",
    "B19" => "Wind Onshore",
    "B20" => "Other",
  }

  def self.countries
    DOMAINS.keys
  end

  def self.aggregated(data)
    {
      bio: data["B01"] + data["B17"],
      gas: data["B04"] + data["B03"],
      coal: data["B02"] + data["B05"],
      oil: data["B06"] + data["B07"],
      peat: data["B08"],
      geo: data["B09"],
      storage: data["B10"],
      hydro: data["B11"] + data["B12"],
      marine: data["B13"],
      nuclear: data["B14"],
      other: data["B15"] + data["B20"],
      solar: data["B16"],
      wind: data["B18"] + data["B19"]
    }.select { |k, v| v != 0 }
  end

  def initialize(country)
    @country = country
  end

  def refresh
    t1 = Date.today.to_time
    t2 = t1 + 1.day
    fmt = "%Y%m%d%H%M"
    params = {
      "documentType" => "A75",
      "processType" => "A16",
      "in_Domain" => DOMAINS[@country],
      "periodStart" => t1.strftime(fmt),
      "periodEnd" => t2.strftime(fmt),
      "securityToken" => ENV["ENTSOE_TOKEN"]
    }
    url = "https://web-api.tp.entsoe.eu/api?#{params.to_query}"
    res = Rails.cache.fetch("viridis:entsoe:#{@country}:1", expires_in: 30.minutes) do
      Rails.logger.debug("Fetching \"#{url}\"")
      RestClient.get(url).body
    end
    @data = Nokogiri::XML(res)
    @time = @data.css("timeInterval end").map { |d| Time.parse(d.content) }.min
    self
  end

  def last
    res = {}
    FUELS.keys.each { |fuel| res[fuel] ||= 0 }
    @data.css("TimeSeries").each do |ts|
      interval = INTERVALS[ts.css("resolution").first.content]
      fuel = ts.css("psrType").first.content
      start = Time.parse(ts.css("timeInterval start").first.content)
      is_negative = ts.css("[codingScheme]").first.name.start_with?("out")
      i = 0
      v = 0
      ts.css("quantity").each do |q|
        i += 1
        v = q.content.to_i * (is_negative ? -1 : 1)
        d = start + interval * i
        res[fuel] += v if d == @time
      end
    end
    res
  end
end
