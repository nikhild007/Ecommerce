Rails.application.routes.draw do
  devise_for :users

  resources :products
  resources :carts
  resources :orders
  resources :cart_items
  resources :order_items

  get '/cart',to: 'carts#index', as: 'get_cart'
  post '/increment/:product_id', to: 'cart_items#increment', as: 'increment_quantity'
  post '/decrement/:product_id', to: 'cart_items#decrement', as: 'decrement_quantity'

  post '/add_to_cart/:product_id', to: 'carts#add_to_cart', as: 'add_to_cart'
  get '/', to: 'home#index', as:'home'

  root to: "home#index" 

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
