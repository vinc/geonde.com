module CarbonIntensity
  extend ActiveSupport::Concern

  module ClassMethods
    # RTE 2023
    RTE_FACTORS = {
      bio:  0.494,
      coal: 0.986,
      gas:  0.429,
      oil:  0.777,
    }

    # IPCC 2011 (http://www.ipcc-wg3.de/report/IPCC_SRREN_Annex_II.pdf)
    IPCC_FACTORS = {
      bio:     0.018,
      coal:    1.001,
      gas:     0.469,
      geo:     0.045,
      hydro:   0.004,
      nuclear: 0.016,
      oil:     0.840,
      solar:   0.046,
      wind:    0.012,
    }

    # NREL 2021 (https://www.nrel.gov/docs/fy21osti/80580.pdf)
    NREL_FACTORS = {
      bio:     0.052,
      coal:    1.001,
      gas:     0.486,
      geo:     0.037,
      hydro:   0.021,
      nuclear: 0.013,
      oil:     0.840,
      solar:   0.043,
      wind:    0.013,
    }

    def carbon_intensity_factors(name)
      case name
      when "rte" then RTE_FACTORS
      when "ipcc" then IPCC_FACTORS
      when "nrel" then NREL_FACTORS
      end
    end

    def carbon_intensity(data, factors: nil)
      return if data.empty?

      total = data.values.sum
      factors = carbon_intensity_factors(factors.present? || "nrel")

      1000 * factors.sum { |k, v| (data[k] || 0) * v } / total
    end
  end
end
