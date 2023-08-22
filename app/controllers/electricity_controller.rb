class ElectricityController < ApplicationController
  def index
    @countries = Country.all.sort_by(&:name)
  end

  def show
    @country = Country.new(params["country"])
  end
end
