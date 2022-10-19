Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "tasks#index"

  delete  "/tasks/:id", to:"tasks#destroy", as: :destroy
  resources :tasks
  post 'search',to:"tasks#search", as: :search
  patch '/users/edit', to: 'users#update'

  #users
  #resources :users, only: [:create]
  get '/users/new', to: 'users#new', as: :new_user
  get '/users/show', to: 'users#show', as: :user
  get '/users/', to: 'tasks#index'
  get '/users/edit/', to: 'users#edit', as: :edit_user
  post '/users', to: 'users#create'
  delete '/users/destroy', to: 'users#destroy', as: :destroy_user

  
  #session
  get '/sessions/new', to: 'sessions#new', as: :new_session
  post '/sessions/new', to: 'sessions#create'
  get '/sessions/destroy', to: 'sessions#destroy', as: :destroy_session

  #admin
  namespace :admin do
    resources :users
  end

  #label
  resources :labels

  match '/404', to: 'errors#not_found', via: :all
  get '/500', to: 'errors#server_errors', via: :all
  
end
