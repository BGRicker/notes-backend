Rails.application.routes.draw do
  resources :notes do
    resources :tags, only: [:create]
  end
  resources :tags, only: [:destroy]
end
