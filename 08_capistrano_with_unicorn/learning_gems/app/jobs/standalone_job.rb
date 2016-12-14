class StandaloneJob

  include Sidekiq::Worker
  sidekiq_options :queue => :default, :retry => true, :backtrace => true

  def perform(args)
    # User.find 10
  end

end