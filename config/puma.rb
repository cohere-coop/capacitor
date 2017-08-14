# frozen_string_literal: true

require_relative "../lib/settings"

threads_count = Settings.app_server_max_threads
threads threads_count, threads_count

port        Settings.app_server_port
environment Settings.app_server_environment
workers     Settings.app_server_concurrency

preload_app!

before_fork do
  ActiveRecord::Base.connection_pool.disconnect! if defined?(ActiveRecord)
end

on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart
