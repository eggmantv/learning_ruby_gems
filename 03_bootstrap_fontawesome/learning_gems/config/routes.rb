Rails.application.routes.draw do

  root 'welcome#index'

  resources :sessions
  resources :users
  delete '/logout' => 'sessions#destroy', as: :logout

end
