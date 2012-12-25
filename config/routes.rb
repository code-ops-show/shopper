Shopper::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  devise_for :users

  namespace :cart do 
    resources :users do 
      resources :addresses, only: [:index]
    end
  end
  resources :categories, only: [:index] do
    resources :products, only: [:index, :show]
  end
  resources :products do 
    resources :items, only: [:create]
  end
  resources :orders
  resources :carts do
    resources :addresses, only: [:new, :create]
  end
  resources :items
  resources :addresses
  resources :users do
    resources :orders
    resources :addresses
  end
  
  root to: 'home#index'

  resources :guests, only: [:new, :create, :update]
  match "/thankful" => "guests#thankful"
end
