# frozen_string_literal: true

class Weather::ForecastController < ApplicationController
  def index
    redirect_to "/weather/#{params[:location].downcase}/forecast"
  end

  def show
    @location = Geocoder.search(params[:location]).first
    raise ActiveRecord::RecordNotFound if @location.nil?

    @weather = Weather.new(@location.latitude, @location.longitude)
  end
end
