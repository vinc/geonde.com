Rails.application.routes.draw do
  get "/electricity", to: "electricity#index"
  get "/electricity/generation", to: "electricity/generation#index"
  get "/electricity/emissions", to: "electricity/emissions#index"
  get "/electricity/generation/:country", to: "electricity/generation#show"
  get "/electricity/emissions/:country", to: "electricity/emissions#show"

  get "/weather", to: "weather#index"
  get "/weather/conditions", to: "weather/conditions#index"
  get "/weather/conditions/search", to: "weather/conditions#search"
  get "/weather/conditions/:airport", to: "weather/conditions#show"
  get "/weather/forecast", to: "weather/forecast#index"
  get "/weather/forecast/search", to: "weather/forecast#search"
  get "/weather/forecast/:city", to: "weather/forecast#show"

  get "/geocode", to: "geocode#index"
  get "/geocode/search", to: "geocode/search#index"

  get "/metar/:airport", to: "metar#show"
  root "pages#home"
end
