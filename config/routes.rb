Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }
  resources :posts do
    resources :comments, only: %i[create]
  end
  root to: 'posts#index'
end
