Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  resources :pages

  get "/dashboard", to: "pages#dashboard"
  resources :portfolios do
    resources :portfolio_songs, only: [:new, :create, :destroy]
    resources :bookings, only: [:new, :create, :index, :show, :destroy, :update] do
      member do
        patch 'accept', to: 'bookings#accept'
        patch 'decline', to: 'bookings#decline'
        patch 'cancel', to: 'bookings#cancel'
      end
    end
  end
end
