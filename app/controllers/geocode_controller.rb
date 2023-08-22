# frozen_string_literal: true

class GeocodeController < ApplicationController
  def index
    @count = GeonamesData.count
  end
end
