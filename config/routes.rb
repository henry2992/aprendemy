Rails.application.routes.draw do

  namespace :student do
    get 'video_classes/index'
    get 'video_classes/show'
  end

  get 'webinar/index'


  resources :events
  
  namespace :backend do

    root 'dashboard#index'
    # get '/update' => 'dashboard#update_image', as: :update_image 

    resources :attitude, only: [:index, :show, :update]
    
    get 'default_choice/:id' => 'choices#update_default_choice', as: :default_choice
    
    resources :courses do
      resources :categories do
        resources :sub_categories do
          resources :questions, except: [:index] do
            resources :choices, except: [:show]
          end
        end
      end
    end
   
  end

  get 'student/courses' => 'student/courses#index', as: :user_root
  
  namespace :student do

    # ATTITUDE TESTS
    # post '/attitude/process' => 'attitude#process', :as => 'attitude_process'
    resources :attitude_tests, :path => "attitude", only: [:index, :show, :update]
    # resources :attitude_tests, :path => "attitude", only: [:index, :show] do
      # resources :course_user_tests, :path => "test", only:[:edit, :new, :update]
    # end
    
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

     # TUTORIALS
      resources :video_classes

    end
    
  end

  # PAYMENTS
  get 'pagos' => 'payments#index', as: :payments

  root 'home#index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # USERS
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", registrations: 'users/registrations', sessions: 'users/sessions', :passwords => "users/passwords" }

  # get 'auth/facebook/callback', to: 'sessions#create'
  # get 'auth/failure', to: redirect('/')
  
  match '*unmatched_route', :to => 'application#raise_not_found!', via: :all
end
