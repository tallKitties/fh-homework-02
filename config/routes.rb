Rails.application.routes.draw do
  root 'books#index'
  resources :books do
    resources :authors, only: :create
    delete "remove_author"
  end
  resources :authors, only: [:show, :index, :edit, :update, :destroy]
end
