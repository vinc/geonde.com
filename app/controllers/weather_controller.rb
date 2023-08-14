# frozen_string_literal: true

class WeatherController < ApplicationController
  def index
  end

  def show
    redirect_to "/weather/#{params[:location].downcase}/forecast"
  end
end
