Rails.application.routes.draw do
  root 'home#index'

  get '/profile', to: 'timelines#show', as: 'self_timeline'
  get '/users/:id', to: 'timelines#show', as: 'timeline'
  get '/biography', to: 'biographies#show', as: 'self_biography'
  get '/biographies/:id', to: 'biographies#show', as: 'biography'
  get '/users/sign_in', to: redirect('')
  resources :posts, only: :create
  resources :biographies, only: [:edit, :update]
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
