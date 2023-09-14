json.zone @country.name
json.time @country.data.time.utc
json.data @country.carbon_intensity(factors: @factors)
json.unit "tCO2eq/MWh"
