Rails.application.routes.draw do

  resources :events
  
  namespace :backend do
  resources :blogs
    get '/dashboard' => 'dashboard#index', :as => 'dashboard'
    # resources :sections
    # resources :tasks
    # resources :schools
    # resources :careers
    # resources :universities
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

      # PAYMENTS
      get '/payments' => 'payments#index', as: :payments

      # TUTORIALS
      resources :tutorials

    end
    
  end

  root 'home#index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # USERS
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks", registrations: 'registrations', sessions: 'sessions' }
  
  # get 'auth/facebook/callback', to: 'sessions#create'
  # get 'auth/failure', to: redirect('/')
  
  match '*unmatched_route', :to => 'application#raise_not_found!', via: :all
end
