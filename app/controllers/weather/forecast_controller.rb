class Weather::ForecastController < ApplicationController
  def index
    @total = GeonamesData.count
  end

  def search
    redirect_to "/api/weather/forecast/#{params[:city].downcase}"
  end

  def show
    time = params[:time]&.to_time || Time.zone.now

    res = GeonamesData.search(params[:city]).first
    raise ActiveRecord::RecordNotFound if res.nil?

    @city = res.name
    @weather = Weather.new(latitude: res.latitude, longitude: res.longitude, time:)
    @sources = ["geonames", "gfs"]
  end
end
