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

  resources :simulators do
    get 'show_simulator_answered_questions', to: 'simulators#show_answered_questions', as: :show_answered_questions
    post 'pause', to: 'simulators#pause_simulator', as: :pause_simulator
    resources :questions do
      resources :simulator_answered_questions
    end
  end

  get 'categories/filter_chart', to: 'simulators#filter_chart', as: :categories_filter_chart
  get 'simulators/filter_chart', to: 'simulators#filter_chart', as: :simulators_filter_chart

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :sessions, only: [:new, :create, :destroy]

  devise_scope :user do
    match '/sessions/user', to: 'devise/sessions#create', via: :post
  end

  # LIVE CLASSES
  get '/live_classes' => 'live_classes#index'

  get '/payments'   => 'home#payments'

end
