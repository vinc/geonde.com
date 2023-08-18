Geocoder.configure(
  http_headers: { "User-Agent" => "Vinua (contact@vinua.com)" }),
  timeout: 10,
  cache: Redis.new,
)
