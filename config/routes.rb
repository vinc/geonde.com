Rails.application.routes.draw do
  get "/electricity", to: "electricity#index"
  get "/electricity/generation", to: "electricity/generation#index"
  get "/electricity/emissions", to: "electricity/emissions#index"
  get "/electricity/:country", to: "electricity#show"
  get "/electricity/:country/generation", to: "electricity/generation#show"
  get "/electricity/:country/emissions", to: "electricity/emissions#show"

  get "/weather", to: "weather#index"
  get "/weather/conditions", to: "weather/conditions#index"
  get "/weather/:city", to: "weather#show"
  get "/weather/:city/conditions", to: "weather/conditions#show"

  get "/geocode", to: "geocode#index"
  get "/geocode/search", to: "geocode/search#index"

  get "/metar/:icao", to: "metar#show"
  root "pages#home"
end
