require 'sidekiq/api'

class MatchMailWorker

  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(h, count)
    h = JSON.load(h)
    emails = (h['emails'].split(" "))
    names = (h['names'].split("."))
    p names
    count = 0
    emails.each do |email|
      MatchMailer.match_mail(email, names[count]).deliver
      count += 1
    end
  end

end
