Rails.application.routes.draw do
  devise_for :users

  resources :posts do
    resources :comments, only: [:create]
  end
  get '/download_model', to: 'application#download_model', as: 'download_model'
  post 'upload_posts_file', to: 'posts#upload_posts_file' # Nova rota para o upload de arquivo

  root to: 'posts#index'
end
