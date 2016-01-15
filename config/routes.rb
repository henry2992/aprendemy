Rails.application.routes.draw do

  root 'home#index'

  get 'app', to: 'app#index'

  #QUESTIONS

  resources :categories do
    resources :sub_categories do
      resources :answered_questions
      resources :questions do
        resources :answers
      end
    end
  end


  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'


  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :sessions, only: [:create, :destroy]




end
