# frozen_string_literal: true

class Country
  attr_reader :code, :data

  COUNTRIES = {
    #"bg" => "Bulgaria",
    #"cy" => "Cyprus",
    #"ie" => "Ireland",
    #"mt" => "Malta",
    "at" => "Austria",
    "be" => "Belgium",
    "ch" => "Switzerland",
    "cz" => "Czech Republic",
    "de" => "Germany",
    "dk" => "Denmark",
    "ee" => "Estonia",
    "es" => "Spain",
    "fi" => "Finland",
    "fr" => "France",
    "gr" => "Greece",
    "hr" => "Croatia",
    "hu" => "Hungary",
    "it" => "Italy",
    "lt" => "Lithuania",
    "lu" => "Luxembourg",
    "lv" => "Latvia",
    "nl" => "Netherlands",
    "no" => "Norway",
    "po" => "Poland",
    "pt" => "Portugal",
    "ro" => "Romania",
    "se" => "Sweden",
    "si" => "Slovania",
    "so" => "Slovakia",
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
    end
  end

  def source
    @data.class.to_s.downcase[0..-5]
  end

  def name
    COUNTRIES[@code]
  end

  def refresh
    @data = @data.refresh
    @fuels = nil
    @carbon_intensity = nil
    self
  end

  def fuels
    @fuels ||= @data.class.aggregated(@data.last)
  end

  def carbon_intensity
    @carbon_intensity ||= @data.class.carbon_intensity(fuels)
  end
end
