Rails.application.routes.draw do
  get 'home/index'

  devise_for :users
  get 'comments/create'

  resources :posts do
  	resources :comments, only: [:create]
  end	

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
