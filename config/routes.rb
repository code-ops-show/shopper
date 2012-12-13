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

  resources :items
  resources :orders
  resources :carts
  resources :products do 
    resources :items, only: [:create]
  end
  resources :categories
  resources :addresses

  root to: 'home#index'
end
