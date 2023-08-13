class ElectricityRefreshJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Country.codes.each do |code|
      Country.new(code)
      sleep 10
    end
  end
end
