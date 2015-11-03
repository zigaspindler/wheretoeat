Rails.application.routes.draw do
  devise_for :users

  root to: 'dashboard#index'
  
  resources :restaurants do
    resources :menus, except: :index
  end
  
  resources :dashboard, only: :index

  resources :comments, only: :create

  post 'vote', to: 'votes#create'
end
