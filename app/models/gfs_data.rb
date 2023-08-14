# frozen_string_literal: true

class GfsData
  def initialize
    @forecast = Forecaster::Forecast.at(Time.now.utc)
  end

  def refresh
    @forecast = Forecaster::Forecast.at(Time.now.utc)
    @forecast.fetch
  end

  def time
    @forecast.time
  end

  def read(key, latitude:, longitude:)
    @forecast.read(key, latitude: latitude, longitude: longitude)
  end
end
