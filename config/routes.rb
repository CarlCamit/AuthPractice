Rails.application.routes.draw do
  get '/sign_up' => 'users#new', as: 'sign_up'
  get '/sign_in' => 'sessions#new', as: 'sign_in'
  delete '/sign_out' => 'sessions#destroy', as: 'sign_out'

  root 'home#welcome'

  resources :users
  resources :sessions
  resources :password_resets
end
