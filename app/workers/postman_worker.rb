# require 'sidekiq/api'

class PostmanWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(h, count)
    h = JSON.load(h)
    UserMailer.register_email(h['email']).deliver
  end

end
