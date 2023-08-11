# frozen_string_literal: true

# https://data.rte-france.com/catalog/-/api/doc/user-guide/Actual+Generation/1.1

class Rte
  SOURCES = [
    "BIOENERGY",
    "EXCHANGE",
    "FOSSIL_GAS",
    "FOSSIL_HARD_COAL",
    "FOSSIL_OIL",
    "HYDRO",
    "NUCLEAR",
    "PUMPING",
    "SOLAR",
    "WIND",
  ]

  def self.aggregated(data)
    {
      bio: data["BIOENERGY"],
      gas: data["FOSSIL_GAS"],
      coal: data["FOSSIL_HARD_COAL"],
      oil: data["FOSSIL_OIL"],
      hydro: data["HYDRO"],
      nuclear: data["NUCLEAR"],
      storage: data["PUMPING"],
      solar: data["SOLAR"],
      wind: data["WIND"],
    }
  end

  def self.carbon_intensity(data)
    total = data.values.sum

    carbon = {}
    carbon[:bio] = 0.494 # CO2eq/MWh
    carbon[:coal] = 0.986
    carbon[:gas] = 0.429
    carbon[:oil] = 0.777

    1000 * %i[bio coal gas oil].map { |k| data[k] * carbon[k] }.sum / total
  end

  def initialize
  end

  def refresh
    t1 = Date.today.to_time
    t2 = t1 + 1.day

    params = {
      "production_subtype" => "TOTAL",
      "start_date" => t1.rfc3339,
      "end_date" => t2.rfc3339,
    }
    url = "https://digital.iservices.rte-france.com/open_api/actual_generation/v1/generation_mix_15min_time_scale?#{params.to_query}"
    res = Rails.cache.fetch("viridis:rte:fr:1", expires_in: 15.minutes) do
      Rails.logger.debug("Fetching #{url}")
      RestClient.get(url, { "Authorization" => "Bearer #{token}" }).body
    end
    @data = JSON.parse(res)
    @updated_at = Time.parse(@data["generation_mix_15min_time_scale"].last["values"].last["updated_date"])
    self
  end

  def last
    res = {}
    @data["generation_mix_15min_time_scale"].each do |d|
      k = d["production_type"]
      v = 0
      d["values"].each do |value|
        break if Time.parse(value["end_date"]) > Time.parse(value["updated_date"])
        v = value["value"].to_i
      end
      res[k] = v
    end
    res
  end

  private

  def token
    client = ENV["RTE_CLIENT"]
    secret = ENV["RTE_SECRET"]
    basic = Base64.strict_encode64("#{client}:#{secret}")

    url = "https://digital.iservices.rte-france.com/token/oauth/"
    res = RestClient.post(url, "", { "Authorization" => "Basic #{basic}" })

    data = JSON.parse(res.body)
    data["access_token"]
  end
end
