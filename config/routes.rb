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

  resource :admin, only: :show, controller: :admin do
    post :create_group
  end

  resource :group, only: [:show, :update] do
    post :add_user
    put :update_restaurants
  end
end
