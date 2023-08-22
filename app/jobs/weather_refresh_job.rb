class WeatherRefreshJob < ApplicationJob
  queue_as :default

  def perform
    GfsData.new.refresh
  end
end
