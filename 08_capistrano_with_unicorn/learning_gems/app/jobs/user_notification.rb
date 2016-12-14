class UserNotification < ApplicationJob

  queue_as :default

  rescue_from(ActiveRecord::ConnectionTimeoutError) do
    retry_job wait: 5.minutes
  end 
  rescue_from(ActiveRecord::RecordNotFound) do
    # do nothing
  end

  def perform(notifications)
    User.find_each do |user|
      # send notification to user
    end
  end

end