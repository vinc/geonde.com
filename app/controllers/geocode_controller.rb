class GeocodeController < ApplicationController
  def index
    @count = GeonamesData.count
  end
end
