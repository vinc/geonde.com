# frozen_string_literal: true

class Country
  attr_reader :code, :data

  COUNTRIES = {
    "ch" => "Switzerland",
    "de" => "Germany",
    "es" => "Spain",
    "fr" => "France",
    "it" => "Italy",
    "se" => "Sweden",
    "uk" => "United Kingdom",
  }

  def self.codes
    (["fr", "uk"] + EntsoeData.countries).uniq.sort
  end

  def self.all
    COUNTRIES.keys.map { |code| Country.new(code) }
  end

  def initialize(code)
    @code = code
    @data = case @code
      when "fr" then RteData.new
      when "uk" then ElexonData.new
      when *EntsoeData.countries then EntsoeData.new(code)
      else raise ActiveRecord::RecordNotFound
    end.refresh
  end

  def name
    COUNTRIES[@code]
  end

  def refresh
    @data = @data.refresh
    @fuels = nil
    @carbon_intensity = nil
  end

  def fuels
    @fuels ||= @data.class.aggregated(@data.last)
  end

  def carbon_intensity
    @carbon_intensity ||= @data.class.carbon_intensity(fuels)
  end
end
