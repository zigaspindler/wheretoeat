Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  root to: 'dashboard#index'
  
  resources :restaurants do
    resources :menus, except: :index
    get 'update_menus', to: 'restaurants#update_menus'
  end
  
  resources :dashboard, only: :index

  resources :comments, only: :create

  resource :votes, only: [:show, :create, :destroy]

  resources :votes do
    resources :comments, only: [:new, :edit, :create, :update]
  end

  resources :settings, only: [:index, :create]

  resource :group, only: [:show, :update] do
    post :add_user
    put :update_restaurants
  end

  resources :balances, only: :index
end
