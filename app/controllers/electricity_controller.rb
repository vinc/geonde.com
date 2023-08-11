# frozen_string_literal: true

class ElectricityController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    render json: {
      time: Time.now.utc,
      data: {
        list: Country.codes
      }
    }
  end

  def show
    expires_in 5.minutes, public: true
    render json: {
      zone: country.name,
      time: country.data.time.utc,
      data: {
        fuels: country.fuels,
        total: country.fuels.values.sum,
      }
    }
  end

  def emissions
    expires_in 5.minutes, public: true
    render json: {
      zone: country.name,
      time: country.data.time.utc,
      data: country.carbon_intensity,
    }
  end

  private

  def country
    @country ||= Country.new(params["country"])
  end

  def record_not_found(error)
    render json: { error: "Not Found" }, status: :not_found
  end
end
