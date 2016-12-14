# config valid only for current version of Capistrano
lock "3.7.0"

set :application, "learning_gems"
set :repo_url, "git@bitbucket.org:rockllei/learning_gems.git"

# Default branch is :master
set :branch, ENV['BRANCH'] || "master"

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/nginx/html/learning_gems"

# custom
set :rails_env, ENV['RAILS_ENV'] || ENV['rails_env']

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sessions", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

