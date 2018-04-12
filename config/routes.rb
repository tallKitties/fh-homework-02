Rails.application.routes.draw do
  root 'books#index'
  resources :books do
    post :new_author
  end
  resources :authorships, only: [:create, :destroy]
  resources :authors,
    only: [:create, :destroy, :update, :edit, :show, :index] do
      delete :remove_book
  end
end
