Rails.application.routes.draw do
  get "/api/electricity", to: "electricity#index"
  get "/api/electricity/:country", to: "electricity#show"
  get "/api/electricity/:country/emissions", to: "electricity#emissions"

  root "pages#home"
end
