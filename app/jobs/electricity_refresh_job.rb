class ElectricityRefreshJob < ApplicationJob
  queue_as :default

  def perform
    Country.codes.each do |code|
      Country.new(code).refresh
      sleep 3
    end
  end
end
