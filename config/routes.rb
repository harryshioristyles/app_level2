Rails.application.routes.draw do

  devise_for :users

  resources :books, only: [:create, :index, :show, :edit, :update, :destroy]
  resources :users, only: [:create, :index, :show, :edit, :update]
  root 'users#home'
  get "home/about" => 'users#about', as:"home_about"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end