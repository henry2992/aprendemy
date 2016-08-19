#!/usr/bin/env puma

directory '/home/deploy/aprendemy/current'
rackup "/home/deploy/aprendemy/current/config.ru"
environment 'production'

pidfile "/home/deploy/aprendemy/shared/tmp/pids/puma.pid"
state_path "/home/deploy/aprendemy/shared/tmp/pids/puma.state"
stdout_redirect '/home/deploy/aprendemy/shared/log/puma_error.log', '/home/deploy/aprendemy/shared/log/puma_access.log', true


threads 0,32

bind 'unix:///home/deploy/aprendemy/shared/tmp/sockets/aprendemy.sock'

workers 0



prune_bundler


on_restart do
   puts 'Refreshing Gemfile'
   ENV["BUNDLE_GEMFILE"] = "/home/deploy/aprendemy/current/Gemfile"
end
