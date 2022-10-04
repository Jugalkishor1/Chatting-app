Rails.application.routes.draw do
  root 'users#index'


  get '/users/dashboard', to: 'users#dashboard'

  delete 'logout', to: 'sessions#destroy'

  get '/users/friends', to: 'users#friends', as: 'friends'

  get '/users/add_friends', to: 'users#add_friends'
  
  get "/users/requests", to: "users#requests", as: "request"
  
  post 'add_friend', to: 'users#send_request', as: 'add_friend'

  patch 'accept/:id', to: 'users#accept_request'

  put 'accept/:id', to: 'users#accept_request', as: :accept_request

  delete 'delete/:id', to: 'users#destroy', as: :delete

  resources :users

  resources :sessions, only: [:new, :create, :destroy]

end