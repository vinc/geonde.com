# frozen_string_literal: true

class Geocode::SearchController < ApplicationController
  def index
    @query = params["q"]
    @results = GeonamesData.search(@query).with_pg_search_rank
    rank_max = @results.first&.pg_search_rank || 0
    @results = @results.to_a.keep_if { |res| res.pg_search_rank == rank_max }
  end
end