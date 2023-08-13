# frozen_string_literal: true

class Electricity::EmissionsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    expires_in 5.minutes, public: true
    @countries = Country.all.sort_by {|c| c.carbon_intensity }
  end

  def show
    expires_in 5.minutes, public: true
    @country = Country.new(params["country"])
  end
end
