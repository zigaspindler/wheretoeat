Rails.application.routes.draw do
  devise_for :users

  root to: 'dashboard#index'
  
  resources :restaurants do
    resources :menus, except: :index
  end
  
  resources :dashboard, only: :index

  resources :comments, only: :create

  resource :vote, only: [:create, :destroy]
end
