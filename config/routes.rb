Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup' }
  get 'landing/index'
  # get 'users/new', to: 'users#new', as: 'new'

  resources :users do 
  	resources :contacts
  end

  root 'landing#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
