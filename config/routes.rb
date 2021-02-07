Rails.application.routes.draw do
  devise_for :users,
    controllers: { 
      registrations: 'registrations',
      sessions: :sessions
    }
  
  root 'top#index'
  resources :users, only: [:show, :index]
  resources :reactions, only: [:create]
  resources :matching, only: [:index]
  resources :chat_rooms, only: [:create, :show]
  resources :qiitas
  namespace :youtube do
    resources :videos
    # resources :myvideos
    get '/myvideos/:q', to: 'myvideos#index', as: 'myvideos'
    patch '/myvideos/:id', to: 'myvideos#update'
    namespace :videos do
      resources :like
      resources :dislike
    end
  end
end
