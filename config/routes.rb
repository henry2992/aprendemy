Rails.application.routes.draw do
  
  root 'home#index'

  get 'app', to: 'app#index'

  #QUESTIONS




  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :sessions, only: [:create, :destroy]


 
 
end
