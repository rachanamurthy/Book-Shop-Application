Rails.application.routes.draw do
  resources :books
  resources :users
  root 'books#index'
end
