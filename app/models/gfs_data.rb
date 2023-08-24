class GfsData
  def initialize(time)
    fetch(time)
  end

  def refresh
    fetch(Time.zone.now)
  end

  def fetch(time)
    @forecast = Forecaster::Forecast.at(time)
    @forecast.fetch
  end

  def time
    @forecast.time
  end

  def read(key, latitude:, longitude:)
    @forecast.read(key, latitude:, longitude:)
  end
end
