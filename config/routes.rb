Rails.application.routes.draw do
  root to: 'home#index'
  resources :car_categories
  resources :subsidiaries, only: [:index, :show, :new, :create]
  resources :car_models, only: [:index, :show]
end
