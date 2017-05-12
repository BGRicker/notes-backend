Rails.application.routes.draw do
  root to: "notes#index"
  resources :notes do
    resources :tags, only: [:create]
  end
  resources :tags, only: [:destroy]
end
