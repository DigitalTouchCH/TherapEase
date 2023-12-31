Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :absences, only: [:new, :create, :edit, :update, :destroy]

  resources :services
  resources :therapists

  resources :week_availabilities do
    resources :time_blocks
  end

  resources :meetings do
    patch 'update_status', on: :member
    resources :media_meetings, only: [:new, :create]
  end


  resources :packages

  resources :media

  resources :patients, only: [:index, :show, :create, :update]

  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#internal_server_error'
  get '/422', to: 'errors#unprocessable'
end
