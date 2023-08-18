# frozen_string_literal: true

class Weather::ConditionsController < ApplicationController
  def index
    redirect_to "/weather/#{params[:city].downcase}/conditions"
  end

  def show
    res = Geocoder.search(params[:city]).first
    raise ActiveRecord::RecordNotFound if res.nil?

    time = params[:time]&.to_time || Time.now
    @city = res.data["name"]
    @weather = Weather.new(latitude: res.latitude, longitude: res.longitude, time: time)
  end
end
