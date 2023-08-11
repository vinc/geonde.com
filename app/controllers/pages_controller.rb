# frozen_string_literal: true

class PagesController < ApplicationController
  def home
  end

  def electricity_emissions
    @countries = Country.all.sort_by {|c| c.carbon_intensity }
  end
end
