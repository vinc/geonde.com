# frozen_string_literal: true

class ElectricityController < ApplicationController
  def index
  end

  def show
    @country = Country.new(params["country"])
  end
end
