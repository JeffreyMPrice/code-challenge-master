require File.expand_path('../initializers/scaling.rb', __FILE__)

rails_env = ENV.fetch('RAILS_ENV', 'development')
puma_port = ENV.fetch('PORT', '5000').to_i
puma_pid_file = ENV.fetch('PIDFILE', 'tmp/pids/server.pid')

port(puma_port)
environment(rails_env)
pidfile(puma_pid_file)
quiet false
threads(MIN_THREADS_COUNT, MAX_THREADS_COUNT)

if rails_env == 'staging' || rails_env == 'production'
  workers(WORKERS_COUNT)
  preload_app!
end
