class Electricity::GenerationController < ApplicationController
  def show
    @country = Country.new(params["country"]).refresh
  end
end
