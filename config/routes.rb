Shopingcart::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  devise_for :users

  resources :categories, only: [:index] do
    resources :products, only: [:index, :show]
  end

  resources :users do
    resources :orders
    resources :addresses
  end

  namespace :cart do 
    resources :users do 
      resources :addresses, only: [:index]
    end
  end

  resources :items
  resources :orders
  resources :carts do
    resources :addresses, only: [:new, :create]
  end
  resources :products do 
    resources :items, only: [:create]
  end
  resources :categories
  resources :addresses

  root to: 'home#index'
  match "/guests/new" => "guests#new"
end
