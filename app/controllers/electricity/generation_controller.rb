class Electricity::GenerationController < ApplicationController
  def index
    codes = params["countries"]&.split(",") || Country.codes
    @countries = codes.map { |code| Country.new(code).refresh }.delete_if(&:empty?).sort_by(&:name)
    @fuels = @countries.flat_map { |c| c.fuels.keys }.sort.uniq
    @sources = @countries.map(&:source).sort.uniq
  end

  def show
    @country = Country.new(params["country"]).refresh
  end
end
