class MetarController < ApplicationController
  def show
    code = params[:airport]
    metar = Metar::Station.find_by_cccc(code.upcase)
    raise ActiveRecord::RecordNotFound if metar.nil?

    respond_to do |format|
      format.html { redirect_to "/weather/conditions/#{code.downcase}" }
      format.json { redirect_to "/weather/conditions/#{code.downcase}.json" }
      format.text { render plain: metar.raw.chomp }
    end
  end
end
