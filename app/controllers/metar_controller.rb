class MetarController < ApplicationController
  def show
    code = params[:icao]
    metar = Metar::Station.find_by_cccc(code.upcase)
    raise ActiveRecord::RecordNotFound if metar.nil?

    respond_to do |format|
      format.html { redirect_to "/weather/#{code.downcase}/conditions?source=metar" }
      format.json { redirect_to "/weather/#{code.downcase}/conditions.json?source=metar" }
      format.text { render plain: metar.raw.chomp }
    end
  end
end
