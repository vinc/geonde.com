# frozen_string_literal: true

class WeatherController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def show
    expires_in 5.minutes, public: true

    loc = Geocoder.search(params[:location]).first
    raise ActiveRecord::RecordNotFound if loc.nil?

    weather = Weather.new(loc.latitude, loc.longitude)

    render json: {
      time: weather.time.utc,
      data: {
        pressure: weather.pressure,
        temperature: weather.temperature,
        humidity: weather.humidity,
        nebulosity: weather.nebulosity,
        radiation: weather.radiation,
        precipitation: weather.precipitation,
        wind: weather.wind,
        wind_direction: weather.wind_direction,
      },
      unit: {
        pressure: "hPa",
        temperature: "°C",
        humidity: "%",
        nebulosity: "%",
        radiation: "W/m²",
        precipitation: "mm",
        wind: "m/s",
        wind_direction: "°",
      },
      zone: loc.city,
    }
  end

  private

  def record_not_found(error)
    render json: { error: "Not Found" }, status: :not_found
  end
end
