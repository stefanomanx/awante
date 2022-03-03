Rails.application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
    get '/users/auth/callback', to: 'omniauth_callbacks#spotify'

  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, only: [ :show, :destroy ] do
    resources :favourites, only: [ :index ]
  end

  resources :artists, only: [ :index, :show ] #CRUD?

  resources :venues, only: [ :index, :show ] #CRUD?

  resources :concerts, only: [:index, :show ] #CRUD?
end
