source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'pg'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
#Bootstrap and Font Awesome
gem 'bootstrap-sass', '~> 3.3', '>= 3.3.6'
gem "font-awesome-rails"
# User Autentification
gem 'devise', '~> 3.5', '>= 3.5.6'
gem 'omniauth'
gem 'omniauth-facebook', '~> 3.0'

#Admin
gem 'rails_admin'
gem 'rename'

#Picture Uploader
gem 'carrierwave', '~> 0.10.0'
gem 'cloudinary'
#Queue
gem "queue_classic", "~> 3.0.0"

#Pagination
gem 'will_paginate', '~> 3.0.6'
gem 'will_paginate-bootstrap', '~> 1.0', '>= 1.0.1'
gem 'kaminari'

#Other
gem 'flipclockjs-rails', '~> 0.7.7'
gem 'haml'


group :production do
  # Production gems
  gem 'figaro'
  gem 'puma'
end


# Add this if you're using rvm
# gem 'capistrano-rvm', github: "capistrano/rvm"

gem "breadcrumbs_on_rails"
gem "wysiwyg-rails"
gem "simple_calendar", "~> 2.0"


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'pry-nav'
  gem 'byebug'
  gem 'pry-rails'
  gem 'foreman'
  gem 'rspec-rails', '~> 3.0'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'database_cleaner'
  gem 'railroady'
  gem 'faker', '~> 1.6', '>= 1.6.3'
  gem 'rubocop', '~> 0.39.0', require: false
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem "better_errors"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Deployment gems
  gem 'capistrano'
  # gem 'capistrano3-puma'
  # gem 'capistrano3-nginx', '~> 2.0'
  gem 'capistrano-rake', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rvm'
  gem 'capistrano-rails-console'
end
