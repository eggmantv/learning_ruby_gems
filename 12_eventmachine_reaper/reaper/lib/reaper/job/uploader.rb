require 'reaper/job/base'

module Reaper
  module Job
    class Uploader < Base

      def do_run
        sleep 2
        puts "Uploader done!"
      end

    end
  end
end