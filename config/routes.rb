Rails.application.routes.draw do

  resources :events
  resources :sections
  resources :tasks
  resources :schools
  resources :careers
  resources :universities

  namespace :backend do
  resources :blogs
    get '/dashboard' => 'dashboard#index', :as => 'dashboard'
  end

  namespace :student do
    resources :courses, only: [:index, :show] do
      # TESTS
      resources :tests, only: [:index] do
        resources :course_user_tests, :path => "test", only:[:edit, :new, :update]
      end
      # PROGRESS
      resources :progress, only: [:index] do
        # RESOURCES
        resources :resources, only: [:show, :update]
      end
      # LIVE CLASSES
      get '/live_classes' => 'live_classes#index'

      # QUESTIONS
      resources :categories do
        resources :sub_categories do
          resources :answers, only:[:create]
        end
      end

      # get '/payments' => 'home#payments', as: :payments

      # TUTORIALS
      resources :tutorials

      # PAYMENTS
      resources :payments


    end
    
    
  end

  

  root 'home#index'

  post 'simulators/filter_chart', to: 'simulators#filter_chart', as: :simulators_filter_chart

  

  resources :simulators do
    get 'show_simulator_answered_questions', to: 'simulators#show_answered_questions', as: :show_answered_questions
    post 'pause', to: 'simulators#pause_simulator', as: :pause_simulator
    post 'finish', to: 'simulators#finish_simulator', as: :finish_simulator
    resources :questions do
      resources :simulator_answered_questions
    end
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # USERS
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks", registrations: 'registrations', sessions: 'sessions' }


  match '*unmatched_route', :to => 'application#raise_not_found!', via: :all

end
