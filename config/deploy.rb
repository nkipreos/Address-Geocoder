# config valid only for current version of Capistrano
lock '3.8.1'

set :application, 'Address-Geocoder'
set :repo_url, 'https://github.com/nkipreos/Address-Geocoder.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/ubuntu/apps/Address-Geocoder'

# Default value for :format is :airbrussh.
# set :format, :airbrussh
set :format, :pretty

set :rbenv_ruby, '2.3.1'
set :rbenv_path, '/home/ubuntu/.rbenv'

# Puma settings
set :puma_conf, "#{shared_path}/config/puma.rb"
set :puma_workers, 2
set :puma_threads, [16, 24]

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, 'config/database.yml', 'config/secrets.yml', 'config/puma.rb', 'config/services_config.yml', 'db/production.sqlite3'

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 3
