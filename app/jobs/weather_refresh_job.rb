class WeatherRefreshJob < ApplicationJob
  queue_as :default

  def perform(*args)
    GfsData.new.refresh
  end
end
