class Electricity::EmissionsController < ApplicationController
  def index
    if params["countries"]
      codes = params["countries"].split(",") || Country.codes
      @countries = codes.map { |code| Country.new(code).refresh }.delete_if(&:empty?).sort_by(&:carbon_intensity)
      @sources = (@countries.map(&:source) << "nrel").sort.uniq
    else
      @countries = Country.all.sort_by(&:name)
      @total = @countries.count
    end
  end

  def show
    @factors = params["factors"]
    @country = Country.new(params["country"]).refresh
  end
end
