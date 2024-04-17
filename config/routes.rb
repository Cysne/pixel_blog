Rails.application.routes.draw do
  devise_for :users
  resources :posts
  root to: 'posts#index'

  resources :comments, only: %i[create]
end
