# frozen_string_literal: true

class Geocoding::SearchController < ApplicationController
  def index
    @query = params["q"]
    @results = GeonamesData.where(name: @query).order(population: :desc)
  end
end
