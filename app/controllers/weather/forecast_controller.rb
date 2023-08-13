# frozen_string_literal: true

class Weather::ForecastController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def show
    expires_in 5.minutes, public: true
    @location = Geocoder.search(params[:location]).first
    raise ActiveRecord::RecordNotFound if @location.nil?
    @weather = Weather.new(@location.latitude, @location.longitude)
  end
end
