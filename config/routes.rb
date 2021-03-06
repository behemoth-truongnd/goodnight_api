Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :time_tracks, only: [:index, :create]
      resources :follows, only: [:create, :destroy], param: :follow_user_id
      resources :users, only: [] do
        resources :time_tracks, only: :index, controller: "users/time_tracks"
      end
    end
  end
end
