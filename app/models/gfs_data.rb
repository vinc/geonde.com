class GfsData
  def initialize(time)
    @time = time
    fetch
  end

  def refresh
    @time = Time.zone.now
    fetch
  end

  def fetch
    @forecast = Forecaster::Forecast.at(@time)
    @forecast.fetch
  end

  def time
    @forecast.time
  end

  def read(key, latitude:, longitude:)
    @forecast.read(key, latitude:, longitude:)
  end
end
