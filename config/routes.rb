Rails.application.routes.draw do

  root 'home#index'

  get '/users/sign_in', to: redirect('')
  get '/users/sign_up', to: redirect('')
  get '/profile', to: 'timelines#show', as: 'self_timeline'
  get '/users/:id', to: 'timelines#show', as: 'timeline'
  get '/biography', to: 'biographies#show', as: 'self_biography'
  get '/biographies/:id', to: 'biographies#show', as: 'biography'
  get '/friends', to: 'friends#show', as: 'self_friends'
  get '/friends/:id', to: 'friends#show', as: 'friends'
  get '/photos', to: 'photos#show', as: 'self_photos'
  get '/photos/:id', to: 'photos#show', as: 'photos'
  get '/feed', to: 'posts#index', as: 'feed'
  post '/friends/accept/:id', to: 'friends#accept', as: 'accept_request'
  post '/friends/decline/:id', to: 'friends#decline', as: 'decline_request'
  post '/friends/new/:id', to: 'friends#create', as: 'send_request'
  post '/notifications/:id/click', to: 'notifications#click', as: 'notifications_click'
  post '/likes/:id', to: 'likes#create', as: 'likes'
  match '/notifications/delete', to: 'notifications#delete_all', as: 'delete_notifications', via: :delete
  resources :posts, only: [:create, :show, :destroy]
  resources :biographies, only: [:edit, :update]
  resources :notifications, only: :index
  resources :comments, only: [:create, :destroy]
  resources :settings, only: [:index, :update]
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
