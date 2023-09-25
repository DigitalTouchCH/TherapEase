Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :absences

  resources :services
  resources :therapists

  resources :week_availabilities do
    resources :time_blocks
  end

  resources :meetings

  resources :packages

  resources :media

  resources :patients, only: [:index, :show, :create, :update]
end
