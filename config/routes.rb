Rails.application.routes.draw do
  resources :friendships
  resources :locations
  resources :profiles, only: [:show, :index]

  devise_for :users

  root to: "locations#index"
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
