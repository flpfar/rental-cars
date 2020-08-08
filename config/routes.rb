Rails.application.routes.draw do
  root to: 'home#index'
  resources :car_categories, only: [:index, :show]
  resources :subsidiaries, only: [:index, :show]
end
