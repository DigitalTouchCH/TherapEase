Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :absences

  resources :week_availabilities do
    resources :time_blocks
  end

  resources :meetings

  resources :packages
end
