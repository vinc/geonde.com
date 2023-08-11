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

      # IPCC 2011 (http://www.ipcc-wg3.de/report/IPCC_SRREN_Annex_II.pdf)
      carbon = {
        bio: 0.018,
        coal: 1.001,
        gas: 0.469,
        geo: 0.045,
        hydro: 0.004,
        nuclear: 0.016,
        oil: 0.840,
        solar: 0.046,
        wind: 0.012,
      }

      # NREL 2021 (https://www.nrel.gov/docs/fy21osti/80580.pdf)
      carbon = {
        bio: 0.052,
        coal: 1.001,
        gas: 0.486,
        geo: 0.037,
        hydro: 0.021,
        nuclear: 0.013,
        oil: 0.840,
        solar: 0.043,
        wind: 0.013,
      }

      1000 * carbon.map { |k, v| (data[k] || 0) * v }.sum / total
    end
  end
end
