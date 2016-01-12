Rails.application.routes.draw do
  

  get 'subcategory/show'

  get 'app', to: 'app#index'


  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'home#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :subcategory
 
end
