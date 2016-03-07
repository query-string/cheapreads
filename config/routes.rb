Rails.application.routes.draw do
  resources :authentication, only: :destroy
  namespace :authentication do
    get ":provider/callback", to: "omniauth#create"
  end
  resources :books, only: [:index, :show, :create] do
    get ":scope", action: :index, as: :scope, on: :collection
    get ":scope/sort/:sort_by/:order_by", action: :index, as: :sort, on: :collection
  end
  root "books#index"
end
