Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"


  resources :absences, only: [:index, :new, :create, :edit, :update]
end
