# https://bmrs.elexon.co.uk/generation-by-fuel-type

class EirgridData
  attr_reader :time

  def self.aggregated(data)
    {}
  end

  def refresh
    t1 = Time.now.utc.beginning_of_day
    t2 = Time.now.utc.end_of_day
    fmt = "%d-%h-%Y+%H:%M"
    api = "https://www.smartgriddashboard.com/DashboardService.svc/data"
    url = "#{api}?area=co2intensity&region=ALL&datefrom=#{t1.strftime(fmt)}&dateto=#{t2.strftime(fmt)}"
    res = Rails.cache.fetch("viridis:semo:ei:1", expires_in: 15.minutes) do
      Rails.logger.debug { "Fetching \"#{url}\"" }
      RestClient.get(url).body
    end
    @data = JSON.parse(res)
    @time = Time.parse(@data["LastUpdated"])
    self
  end

  def empty?
    @data.nil?
  end

  def last
    raise ActiveRecord::RecordNotFound if empty?
  end

  def official_carbon_intensity
    @data["Rows"].pluck("Value").compact.last.to_f
  end

  def self.carbon_intensity(data)
  end
end
