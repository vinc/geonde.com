Rails.application.routes.draw do
  get "/electricity", to: "electricity#index"
  get "/electricity/emissions", to: "electricity/emissions#index"
  get "/electricity/:country", to: "electricity#show"
  get "/electricity/:country/generation", to: "electricity/generation#show"
  get "/electricity/:country/emissions", to: "electricity/emissions#show"

  get "/weather", to: "weather#index"
  get "/weather/forecast", to: "weather/forecast#index"
  get "/weather/:location", to: "weather#show"
  get "/weather/:location/forecast", to: "weather/forecast#show"

  root "pages#home"
end
