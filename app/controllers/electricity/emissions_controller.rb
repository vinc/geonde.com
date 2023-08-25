class Electricity::EmissionsController < ApplicationController
  def index
    codes = params["countries"]&.split(",") || Country.codes
    @countries = codes.map { |code| Country.new(code).refresh }.delete_if(&:empty?).sort_by(&:carbon_intensity)
    @sources = (@countries.map(&:source) << "nrel").sort.uniq
  end

  def show
    @country = Country.new(params["country"]).refresh
  end
end
