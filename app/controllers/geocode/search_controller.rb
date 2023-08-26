class Geocode::SearchController < ApplicationController
  def index
    @total = GeonamesData.count
    @query = params["q"]
    if @query.present?
      @results = GeonamesData.search(@query).with_pg_search_rank
      rank_max = @results.first&.pg_search_rank || 0
      @results = @results.to_a.keep_if { |res| res.pg_search_rank == rank_max }
    end
  end
end
