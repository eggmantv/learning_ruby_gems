require "optparse"
require File.expand_path('../../main', __FILE__)

module Reaper
  def self.main
    options = {
      run_as_daemon: false,
      env: 'development'
    }

    opts = OptionParser.new do |opts|
      opts.banner = "Usage: #{$0} use -h to show help"

      opts.on("-e", "--environment environment", 
              "development | production, development by default") do |env|
        if env
          if %w[development production].include?(env)
            options[:env] = env
          else
            puts "environments: development | production"
            exit 1
          end
        end
      end

      opts.on("-D", "--daemon", 
              "run as daemon") do |x|
        options[:run_as_daemon] = true
      end
    end

    opts.parse!

    # load config
    config = Reaper::Config.new(options)

    # run
    run_proc = proc { Reaper::Daemon.run(config, options[:run_as_daemon]) }
    if options[:run_as_daemon]
      pid = fork { run_proc.call }
      puts "Reaper started, pid: #{pid}"

      pid_file = File.expand_path('../../reaper.pid', __FILE__)
      File.open(pid_file, 'w') { |f| f.puts pid }
    else
      run_proc.call
    end
  end

end
