Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: 'pages#main'
  get '/dashboard', to: 'pages#dashboard'

  resources :sessions, only: [:create]
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  resources :password_resets

  resources :products do
    get '/orders/:id/payment', to: 'orders#edit', as: 'payment_order'
    resources :orders
  end

end
