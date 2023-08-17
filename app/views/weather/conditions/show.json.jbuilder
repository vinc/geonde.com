json.zone @city
json.time @weather.time.utc
json.data do
  json.pressure @weather.pressure
  json.temperature @weather.temperature
  json.humidity @weather.humidity
  json.nebulosity @weather.nebulosity
  json.radiation @weather.radiation
  json.precipitation @weather.precipitation
  json.wind @weather.wind
  json.wind_direction @weather.wind_direction
end
json.unit do
  json.pressure "hPa"
  json.temperature "°C"
  json.humidity "%"
  json.precipitation "mm"
  json.wind "m/s"
  json.wind_direction "°"
  json.nebulosity "%"
  json.radiation "W/m²"
end
