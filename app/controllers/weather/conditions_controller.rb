# frozen_string_literal: true

class Weather::ConditionsController < ApplicationController
  def index
    redirect_to "/weather/#{params[:location].downcase}/conditions"
  end

  def show
    @location = Geocoder.search(params[:location]).first
    raise ActiveRecord::RecordNotFound if @location.nil?

    @weather = Weather.new(@location.latitude, @location.longitude)
  end
end
