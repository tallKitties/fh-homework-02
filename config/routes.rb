Rails.application.routes.draw do
  root 'books#index'
  resources :books do
    resources :authors, only: :create
  end
  resources :authors, only: [:show, :index, :edit, :update, :destroy]
end
