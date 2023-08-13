json.zone @country.name
json.time @country.data.time.utc
json.data do
  json.fuels @country.fuels
  json.total @country.fuels.values.sum
end
json.unit "MW"
