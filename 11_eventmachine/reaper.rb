#
# 使用：
#
# $ruby reaper.rb
#

require 'eventmachine'

def job_1
  while true
    sleep 1
    puts "job 1 done"
  end
end

def job_2
  while true
    sleep 2
    puts "job 2 done"
  end
end


EM.run do

  EM.defer proc { job_1 }
  EM.defer proc { job_2 }

  trap('INT') do
    puts "ctrl+c received, exit"
    EM.stop
  end

end
