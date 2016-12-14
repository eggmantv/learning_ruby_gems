Rails.application.routes.draw do

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq-stat'

  root 'welcome#index'

  resources :sessions
  resources :users
  delete '/logout' => 'sessions#destroy', as: :logout

end
