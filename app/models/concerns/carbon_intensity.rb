module CarbonIntensity
  extend ActiveSupport::Concern

  module ClassMethods
    def carbon_intensity(data)
      total = data.values.sum
      
      # RTE (tCO2eq/MWh)
      carbon = {
        bio: 0.494,
        coal: 0.986,
        gas: 0.429,
        oil: 0.777,
      }

      # IPCC 2014
      # UNECE 2020
      carbon = {
        bio: 0.230,
        gas: 0.430,
        coal: 1.000,
        oil: 0.777,
        geo: 0.030,
        hydro: 0.010,
        nuclear: 0.005,
        solar: 0.040,
        wind: 0.012,
      }

      1000 * carbon.map { |k, v| (data[k] || 0) * v }.sum / total
    end
  end
end
