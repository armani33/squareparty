Rails.application.routes.draw do


  root to: 'pages#main'
  get '/dashboard', to: 'pages#dashboard'

  resources :products do
    get '/orders/:id/payment', to: 'orders#edit', as: 'payment_order'
    resources :orders
  end
end
