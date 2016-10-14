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

  get 'student/courses' => 'student/courses#index', as: :user_root
  
  namespace :student do

    resources :courses, only: [:index, :show] do
      # root_path
      
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

      # TUTORIALS
      resources :tutorials

      #STATISTICS
      resources :statistics, only: [:index]

    end
    
  end

  # PAYMENTS
  get 'payments' => 'payments#index', as: :payments

  root 'home#index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # USERS
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", registrations: 'users/registrations', sessions: 'users/sessions' }

  # get 'auth/facebook/callback', to: 'sessions#create'
  # get 'auth/failure', to: redirect('/')
  
  match '*unmatched_route', :to => 'application#raise_not_found!', via: :all
end
