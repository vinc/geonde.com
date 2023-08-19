# frozen_string_literal: true

class GfsData
  def initialize(time)
    @time = time
    fetch
  end

  def refresh
    @time = Time.now
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
    @forecast.read(key, latitude: latitude, longitude: longitude)
  end
end
