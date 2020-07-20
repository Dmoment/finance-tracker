Rails.application.routes.draw do
  
  resources :user_stocks, only: [:create,:destroy]
  resources :friendships, only: [:create,:destroy]
  root to:'welcome#index'
  devise_for :users, controllers: { confirmations: 'confirmations' }
  
  resources :users, only: [:show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'search_stocks', to: 'stocks#search'
  get 'my_friends', to: 'users#my_friends'
  get 'search_friends', to: 'users#search'
  
end
