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
gem 'kaminari'

#Other
gem 'flipclockjs-rails', '~> 0.7.7'
gem 'figaro'
gem 'haml'

gem 'capistrano', '~> 3.4.0'
gem 'capistrano-bundler', '~> 1.1.2'
gem 'capistrano-rails', '~> 1.1.1'

# Add this if you're using rbenv
gem 'capistrano-rbenv', github: "capistrano/rbenv"

# Add this if you're using rvm
# gem 'capistrano-rvm', github: "capistrano/rvm"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'pry-nav'
  gem 'byebug'
  gem 'pry-rails'
  gem 'foreman'
  gem 'rspec-rails', '~> 3.0'
  gem 'factory_girl'
  gem 'database_cleaner'
  gem 'railroady'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem "better_errors"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :production do
  gem 'puma', '~> 2.16'
  gem 'rails_12factor'
end
