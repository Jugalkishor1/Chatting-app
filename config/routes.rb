require 'sidekiq/web'

Rails.application.routes.draw do
   devise_for :users, controllers: { sessions: 'users/sessions', registrations: "users/registrations",
      :omniauth_callbacks => "users/omniauth_callbacks" }

  root 'users#index'

  mount Sidekiq::Web => '/sidekiq'

  mount ActionCable.server => '/cable'

  get 'search', to: 'users#friends'

  get 'search_all', to: 'users#add_friends'

  get '/users/dashboard', to: 'users#dashboard'

  delete 'logout', to: 'sessions#destroy'

  get '/users/friends', to: 'users#friends', as: 'friends'

  get '/users/add_friends', to: 'users#add_friends'
  
  get "/users/requests", to: "users#requests", as: "request"
  
  post 'add_friend', to: 'users#send_request', as: 'add_friend'

  patch 'accept/:id', to: 'users#accept_request'

  put 'accept/:id', to: 'users#accept_request', as: :accept_request

  delete 'delete/:id', to: 'users#destroy', as: :delete

  post 'show_chats', to: 'chats#show_chats'

  post 'send_messages', to: 'chats#send_messages'
  
  post 'create_group', to: 'chats#create_group'
  
  post 'group_chats', to: 'chats#group_chats'

  delete 'delete_message/:id', to: 'chats#delete_message', as: "delete_message"
  
  get 'profile', to: 'posts#profile'

  get 'comments', to: 'comments#show_comments'

  get 'reply_form', to: 'comments#reply_form'

  post 'reply_comment', to: 'comments#reply_comment'

  put 'unlike_post', to: 'likes#unlike_post'
  
  patch 'unlike_post', to: 'likes#unlike_post'


  resources :users, only: [:index, :show]

  resources :posts

  resources :comments, only: [:create]

  resources :likes

  resources :chats, only: [:index]

  # resources :sessions, only: [:new, :create, :destroy]

end