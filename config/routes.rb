Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :artists, only: [ :show ] #CRUD?

  resources :venues, only: [ :show, ] #CRUD?

  resources :concerts, only: [:index, :show ] #CRUD?
end
