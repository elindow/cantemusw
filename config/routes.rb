Rails.application.routes.draw do
  root 'concerts#index'
  resources :songs
  resources :singers
  resources :concerts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end