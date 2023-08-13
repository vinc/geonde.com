# frozen_string_literal: true

class ElectricityController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    expires_in 5.minutes, public: true
  end

  def show
    expires_in 5.minutes, public: true
    @country = Country.new(params["country"])
  end
end
