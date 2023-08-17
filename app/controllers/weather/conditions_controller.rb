# frozen_string_literal: true

class Weather::ConditionsController < ApplicationController
  def index
    redirect_to "/weather/#{params[:city].downcase}/conditions"
  end

  def show
    location = Geocoder.search(params[:city]).first
    raise ActiveRecord::RecordNotFound if location.nil?

    @city = location.city
    @weather = Weather.new(location.latitude, location.longitude)
  end
end
