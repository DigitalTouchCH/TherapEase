Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"


  resources :absences, only: [:index, :new, :create, :edit, :update]

  resources :week_availabilities do
    resources :time_blocks, only: [:new, :create, :edit, :update, :destroy]
  end

end
