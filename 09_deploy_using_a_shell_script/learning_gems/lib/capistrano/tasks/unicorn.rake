namespace :deploy do
  namespace :unicorn_mine do
    desc "start unicorn"
    task :start do
      unicorn_container :start
    end

    desc "reload unicorn"
    task :reload do
      unicorn_container :reload
    end

    desc "stop unicorn"
    task :stop do
      unicorn_container :stop
    end

    def start_unicorn_cmd
      execute "cd #{current_path}; bundle exec unicorn_rails -E #{fetch(:rails_env)} -c config/unicorn.rb -D"
    end

    def unicorn_container action_name
      on roles(:web) do |host|
        puts "*" * 50
        puts "#{action_name} unicorn..."
        if test("[ -f #{current_path}/tmp/pids/unicorn.pid ]")
          unicorn_pid = capture("cat #{current_path}/tmp/pids/unicorn.pid")
          puts "unicorn is running"
          case action_name
          when :start
            ;;
          when :stop
            puts "stop now..."
            execute "cd #{current_path}; kill #{unicorn_pid}"
          when :reload
            puts "reload now..."
            execute "cd #{current_path}; kill -s USR2 #{unicorn_pid}"
          end
        else
          puts "unicorn was not started"
          case action_name
          when :start
            puts "start now..."
            start_unicorn_cmd
          when :stop
            ;;
          when :reload
            puts "start now..."
            start_unicorn_cmd
          end
          # invoke "deploy:start_unicorn"
        end
      end
    end
  end

end