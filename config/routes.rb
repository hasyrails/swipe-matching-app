Rails.application.routes.draw do
  devise_for :users,
    controllers: { 
      registrations: 'registrations',
      sessions: :sessions,
      passwords: 'passwords'
    }
    
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  root 'top#index'
  resources :users, only: [:show, :index], param: :user_id
  resources :users do
    resources :video_share, only: [:new, :create], controller: 'users/video_share'
    resource :status do
      resources :like, only: [:index], controller: 'users/status/like'
    end
  end
  resources :reactions, only: [:create]
  resources :matching, only: [:index]
  resources :chat_rooms, only: [:create, :show]
  namespace :users do
    get 'video_common_like/:video_unique_id',  to: 'video_common_like#index', as: 'video_common_like'
  end
  namespace :youtube do
    resources :videos_search
    get '/myvideos/:q', to: 'myvideos#index', as: 'myvideos'
    namespace :myvideos do
      resources :favorites, only: [:create, :update]
      namespace :status   do
        resources :like, only: [
          :index, 
          :destroy
        ]
        namespace :like do
          resources :share, only: [:new, :create]
          resources :shared_and_sharing_history, only: [:show], param: :user_id
          resources :sharing_videos, only: [:index]
          resources :sharing_videos, param: :video_unique_id, only: [:show]
          resources :shared_and_sharing_videos, only: [:show]
        end
        get 'like/:keyword', to: 'like#index'
        resources :dislike, only: [:index, :destroy]
      end
    end
  end
  namespace :admin do
    root 'top#index'
    resources :dashboard, only: [:index]
    resource :dashboard do
      resources :users, controller: 'dashboard/users'
      resources :youtube_videos, controller: 'dashboard/youtube_videos'
      resources :chat_rooms, controller: 'dashboard/chat_rooms'
      resources :chat_room_users, controller: 'dashboard/chat_room_users'
      resources :chat_messages, controller: 'dashboard/chat_messages'
      resources :reactions, controller: 'dashboard/reactions'
      resources :favorites, controller: 'dashboard/favorites'
      resources :share_videos, controller: 'dashboard/share_videos'
    end
  end
  namespace :demo_admin do
    root 'top#index'
    resources :dashboard, only: [:index]
    resource :dashboard do
      resources :users, controller: 'dashboard/users'
      resources :youtube_videos, controller: 'dashboard/youtube_videos'
      resources :chat_rooms, controller: 'dashboard/chat_rooms'
      resources :chat_room_users, controller: 'dashboard/chat_room_users'
      resources :chat_messages, controller: 'dashboard/chat_messages'
      resources :reactions, controller: 'dashboard/reactions'
      resources :favorites, controller: 'dashboard/favorites'
      resources :share_videos, controller: 'dashboard/share_videos'
    end
  end

end
