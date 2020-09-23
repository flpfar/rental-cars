Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :car_categories
  resources :subsidiaries, only: [:index, :show, :new, :create, :edit, :update]
  resources :car_models, only: [:index, :show, :new, :create]
  resources :customers, only: [:index, :new, :create, :show]
  resources :rentals, only: [:index, :new, :create, :show] do
    resources :car_rentals, only: [:new, :create]
    get 'search', on: :collection
  end
  namespace :api do
    namespace :v1 do
      resources :cars, only: [:index]
    end
  end
end
