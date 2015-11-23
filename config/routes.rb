Rails.application.routes.draw do
  devise_for :users

  root to: 'dashboard#index'
  
  resources :restaurants do
    resources :menus, except: :index
    get 'update_menus', to: 'restaurants#update_menus'
  end
  
  resources :dashboard, only: :index

  resources :comments, only: :create

  resource :vote, only: [:create, :destroy]

  resources :settings, only: [:index, :create]
end
