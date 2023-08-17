# frozen_string_literal: true

class Electricity::EmissionsController < ApplicationController
  def index
    @countries = Country.all.map(&:refresh).sort_by(&:carbon_intensity)
  end

  def show
    @country = Country.new(params["country"]).refresh
  end
end
