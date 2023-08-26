class Weather::ConditionsController < ApplicationController
  def index
    @total = Metar::Station.all.count
  end

  def search
    redirect_to "/weather/conditions/#{params[:airport].downcase}"
  end

  def show
    time = params[:time]&.to_time || Time.zone.now

    @airport = params[:airport].upcase
    station = Metar::Station.find_by_cccc(@airport)
    raise ActiveRecord::RecordNotFound if station.nil?

    @city = station.name
    @weather = Weather.new(latitude: station.latitude, longitude: station.longitude, time:, metar: station.parser)
    @sources = ["metar"]
  end
end
