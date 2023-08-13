# frozen_string_literal: true

class Electricity::GenerationController < ApplicationController
  def show
    @country = Country.new(params["country"])
  end
end
