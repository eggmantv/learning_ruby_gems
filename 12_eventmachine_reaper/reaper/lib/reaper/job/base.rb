module Reaper
  module Job

    class Base
      def initialize
        puts "#{self.class.name} registered!"
        run
      end

      def run
        ops = proc do
          begin
            do_run
          rescue => e
            puts "uncaught exception in job: #{e}"
          end
        end
        
        callback = proc { |result| run }

        EM.defer(ops, callback)
      end

      def do_run
        raise "Need to implement `do_run` method"
      end

      alias :old_puts :puts
      def puts txt
        old_puts "#{Time.now.utc.strftime("%F %T")} #{txt}"
      end

    end


  end
end