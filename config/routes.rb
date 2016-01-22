Rails.application.routes.draw do
  namespace :authentication do
    get ":provider/callback", to: "omniauth#create"
  end
end
