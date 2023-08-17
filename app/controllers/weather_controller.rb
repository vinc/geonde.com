# frozen_string_literal: true

class WeatherController < ApplicationController
  def index
  end

  def show
    redirect_to "/weather/#{params[:city].downcase}/conditions"
  end
end
