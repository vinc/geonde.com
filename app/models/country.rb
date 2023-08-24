class Country
  attr_reader :code, :data

  COUNTRIES = {
    "at" => "Austria",
    "be" => "Belgium",
    "bg" => "Bulgaria",
    "ch" => "Switzerland",
    "cy" => "Cyprus",
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
    "ie" => "Ireland",
    "it" => "Italy",
    "lt" => "Lithuania",
    "lu" => "Luxembourg",
    "lv" => "Latvia",
    "mt" => "Malta",
    "nl" => "Netherlands",
    "no" => "Norway",
    "po" => "Poland",
    "pt" => "Portugal",
    "ro" => "Romania",
    "se" => "Sweden",
    "si" => "Slovania",
    "so" => "Slovakia",
    "uk" => "United Kingdom",
  }.freeze

  def self.codes
    (%w[fr uk] + EntsoeData.countries).uniq.sort
  end

  def self.all
    COUNTRIES.keys.map { |code| Country.new(code) }
  end

  def initialize(code)
    @code = code
    @data = case @code
    when "fr"
      RteData.new
    when "uk"
      ElexonData.new
    when *EntsoeData.countries
      EntsoeData.new(code)
    else
      ActiveRecord::RecordNotFound
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

  def empty?
    @data.empty?
  end

  def fuels
    @fuels ||= @data.class.aggregated(@data.last)
  end

  def carbon_intensity
    @carbon_intensity ||= @data.class.carbon_intensity(fuels).round(1)
  end
end
