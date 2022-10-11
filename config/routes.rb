Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "tasks#index"

  delete  "/tasks/:id", to:"tasks#destroy", as: :destroy
  resources :tasks
  post 'search',to:"tasks#search", as: :search
  patch '/users/edit', to: 'users#update'

  #users
  resources :users, only: [:new, :create]
  get '/users', to: 'users#show', as: :show
  get '/users/edit/', to: 'users#edit', as: :edit_user
  get '/users', to: 'users#create', as: :user
  delete '/users/destroy', to: 'users#destroy', as: :destroy_user

  
  #session
  get '/sessions/new', to: 'sessions#new', as: :new_session
  post '/sessions/new', to: 'sessions#create'
  get '/sessions/destroy', to: 'sessions#destroy', as: :destroy_session
end
