Rails.application.routes.draw do

  root "pages#index"
  get "/tracking", to: "pages#tracking" 

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
