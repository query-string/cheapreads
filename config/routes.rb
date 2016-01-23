Rails.application.routes.draw do
  namespace :authentication do
    get ":provider/callback", to: "omniauth#create"
  end
  resources :books, only: [:index, :show]
  root "books#index"
end
