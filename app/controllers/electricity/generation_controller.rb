class Electricity::GenerationController < ApplicationController
  def index
    @countries = Country.all.map(&:refresh).delete_if(&:empty?).sort_by(&:name)
    @fuels = @countries.flat_map { |c| c.fuels.keys }.sort.uniq
    @sources = @countries.map(&:source).sort.uniq
  end

  def show
    @country = Country.new(params["country"]).refresh
  end
end
