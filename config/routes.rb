Rails.application.routes.draw do
  get "/electricity", to: redirect("/api/electricity")
  get "/electricity(/*all)", to: redirect("/api/electricity/%{all}")
  get "/geocode", to: redirect("/api/geocode")
  get "/geocode(/*all)", to: redirect("/api/geocode/%{all}")
  get "/weather", to: redirect("/api/weather")
  get "/weather(/*all)", to: redirect("/api/weather/%{all}")

  get "/api/electricity", to: "electricity#index"
  get "/api/electricity/generation", to: "electricity/generation#index"
  get "/api/electricity/emissions", to: "electricity/emissions#index"
  get "/api/electricity/generation/:country", to: "electricity/generation#show"
  get "/api/electricity/emissions/:country", to: "electricity/emissions#show"

  get "/api/weather", to: "weather#index"
  get "/api/weather/conditions", to: "weather/conditions#index"
  get "/api/weather/conditions/search", to: "weather/conditions#search"
  get "/api/weather/conditions/:airport", to: "weather/conditions#show"
  get "/api/weather/forecast", to: "weather/forecast#index"
  get "/api/weather/forecast/search", to: "weather/forecast#search"
  get "/api/weather/forecast/:city", to: "weather/forecast#show"

  get "/api/geocode", to: "geocode#index"
  get "/api/geocode/search", to: "geocode/search#index"

  get "/api/metar/:airport", to: "metar#show"

  get "/api", to: "pages#api"
  root "pages#home"
end
