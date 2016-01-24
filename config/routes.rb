Rails.application.routes.draw do
  resources :authentication, only: :destroy
  namespace :authentication do
    get ":provider/callback", to: "omniauth#create"
  end
  resources :books, only: [:index, :show, :create]
  root "books#index"
end
