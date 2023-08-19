Rails.application.routes.draw do
  get "/electricity", to: "electricity#index"
  get "/electricity/emissions", to: "electricity/emissions#index"
  get "/electricity/:country", to: "electricity#show"
  get "/electricity/:country/generation", to: "electricity/generation#show"
  get "/electricity/:country/emissions", to: "electricity/emissions#show"

  get "/weather", to: "weather#index"
  get "/weather/conditions", to: "weather/conditions#index"
  get "/weather/:city", to: "weather#show"
  get "/weather/:city/conditions", to: "weather/conditions#show"

  get "/geocoding", to: "geocoding#index"
  get "/geocoding/search", to: "geocoding/search#index"

  root "pages#home"
end
