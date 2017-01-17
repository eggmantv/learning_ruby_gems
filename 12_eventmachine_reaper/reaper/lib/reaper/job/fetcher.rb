require 'reaper/job/base'

module Reaper
  module Job
    class Fetcher < Base

      def do_run
        sleep 1
        puts "Fetcher done!"
      end
    end

  end
end