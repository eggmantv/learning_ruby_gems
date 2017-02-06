module Reaper
  module Daemon

    class << self
      attr_accessor :logger
      attr_accessor :log_file
    end

    def self.run config, run_as_daemon = false
      setup_logger(run_as_daemon)

      EM.run do
        puts "Start process.."
        puts "PID: #{Process.pid}"

        # register jobs
        Reaper::Job::Fetcher.new
        Reaper::Job::Uploader.new

        handle_signal
      end
    end

    protected
    def self.setup_logger run_as_daemon
      self.log_file = File.expand_path('../../../run.log', __FILE__)
      FileUtils.touch(self.log_file) unless File.exists?(self.log_file)
      self.logger = Logger.new(self.log_file)

      if run_as_daemon
        $stdout.reopen(self.log_file, "a+")
        $stdout.sync = true
        $stderr.reopen($stdout)
      end
    end

    def self.handle_signal
      [:INT, :QUIT, :TERM].each do |sig|
        trap(sig) do
          # clear pid file
          pid_file = File.expand_path('../../../reaper.pid', __FILE__)
          FileUtils.rm_f(pid_file) if File.exists?(pid_file)
          puts "#{sig} signal received, exit!"

          EM.stop
        end
      end
    end

  end

end
