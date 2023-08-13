# frozen_string_literal: true

class Electricity::EmissionsController < ApplicationController
  def index
    @countries = Country.all.sort_by {|c| c.carbon_intensity }
  end

  def show
    @country = Country.new(params["country"])
  end
end
