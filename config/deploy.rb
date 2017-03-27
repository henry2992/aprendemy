# config valid only for current version of Capistrano
# lock '3.6.0'

set :application, 'aprendemy'
set :repo_url, 'git@github.com:henry2992/aprendemy.git' # Edit this to match your repository
set :deploy_to, '/home/deploy/aprendemy'
set :pty, true
set :linked_files, %w{config/database.yml config/application.yml config/puma.rb config/cloudinary.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}
set :keep_releases, 5

set :rvm_type, :user
set :rvm_ruby_version, 'ruby-2.3.1' # Edit this if you are using MRI Ruby
set :rvm_custom_path, '~/.rvm'

set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/aprendemy.sock"    #accept array for multi-bind
set :puma_conf, "#{shared_path}/config/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_error.log"
set :puma_error_log, "#{shared_path}/log/puma_access.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads, [0, 32]
set :puma_workers, 0
set :puma_worker_timeout, nil
set :puma_init_active_record, true
set :puma_preload_app, false

namespace :rake do  
  desc "Run a task on a remote server."  
  # run like: cap staging rake:invoke task=a_certain_task  
  task :invoke do
    run "cd #{deploy_to}/current"
    run "bundle exec rake #{ENV['task']} RAILS_ENV=#{rails_env}"
  end  
end