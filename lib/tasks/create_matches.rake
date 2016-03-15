require 'sidekiq/api'
require_relative '../../app/workers/match_worker'

namespace :create_matches do

  task :match => :environment do

    MatchMakingWorker.perform_async

  end
end
