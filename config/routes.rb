Rails.application.routes.draw do
  root 'home#index'

  get '/profile', to: 'timelines#show', as: 'timeline'
  get '/users/sign_in', to: redirect('')
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
