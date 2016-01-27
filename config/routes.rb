Rails.application.routes.draw do

  root 'home#index'


  #QUESTIONS
  resources :categories do
    resources :sub_categories do
      get 'show_answered_questions', to: 'sub_categories#show_answered_questions', as: :show_answered_questions
      resources :questions do
        resources :answered_questions
        resources :choices
      end
    end
  end


  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :sessions, only: [:new, :create, :destroy]

  devise_scope :user do
    match '/sessions/user', to: 'devise/sessions#create', via: :post
  end

end
