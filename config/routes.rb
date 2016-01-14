Rails.application.routes.draw do
  


  get 'app', to: 'app#index'

  #QUESTIONS
   post "subcategory/question"
   get "subcategory/question"
   post "subcategory/answer"




  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'home#index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :subcategory

  resources :exercise
 
end
