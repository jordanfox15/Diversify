require 'sidekiq/api'

class EmailWorker

  include Sidekiq::Worker
  sidekiq_options retry: false

end
