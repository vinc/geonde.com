# frozen_string_literal: true

class ElectricityController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    render json: {
      time: Time.now.utc,
      data: {
        list: (["fr", "uk"] + Entsoe.countries).uniq.sort
      }
    }
  end

  def show
    expires_in 5.minutes, public: true
    data = fetch_data
    render json: {
      time: data.time.utc,
      data: {
        fuels: data.class.aggregated(data.last),
        total: data.last.values.sum
      }
    }
  end

  def emissions
    expires_in 5.minutes, public: true
    data = fetch_data
    render json: {
      time: data.time.utc,
      data: data.class.carbon_intensity(data.class.aggregated(data.last))
    }
  end

  private

  def fetch_data
    code = params["country"]
    case code
    when "fr" then Rte.new
    when "uk" then Elexon.new
    when *Entsoe.countries then Entsoe.new(code)
    else raise ActiveRecord::RecordNotFound
    end.refresh
  end

  def record_not_found(error)
    render json: { error: "Not Found" }, status: :not_found
  end
end
