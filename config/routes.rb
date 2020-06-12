Rails.application.routes.draw do
  root 'users#top'

  get "home/about" => "homes#about"


  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :books, only: [:new, :create, :index, :show, :destroy, :edit, :update]

  resources :users, only: [:index, :show, :edit, :update]
end