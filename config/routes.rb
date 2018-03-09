Rails.application.routes.draw do
  resources :authors
  root 'books#index'
  resources :books
end
