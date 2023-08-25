class Weather::ConditionsController < ApplicationController
  def index
    redirect_to "/weather/#{params[:city].downcase}/conditions"
  end

  def show
    time = params[:time]&.to_time || Time.zone.now

    if params[:source] == "metar"
      station = Metar::Station.find_by_cccc(params[:city].upcase)
      @city = station.name
      @weather = Weather.new(latitude: station.latitude, longitude: station.longitude, time:, metar: station.parser)
      @sources = ["metar"]
    else
      res = GeonamesData.search(params[:city]).first
      raise ActiveRecord::RecordNotFound if res.nil?

      @city = res.name
      @weather = Weather.new(latitude: res.latitude, longitude: res.longitude, time:)
      @sources = ["geonames", "gfs"]
    end
  end
end
