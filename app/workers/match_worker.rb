require 'sidekiq/api'

class MatchMakingWorker

  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform

    def match_interests(first_interests, second_interests, interest_count = 0)
      if first_interests.include?(second_interests[interest_count])
        return true
      elsif interest_count == (second_interests.length - 1)
        return false
      else
        match_interests(first_interests, second_interests, interest_count + 1)
      end
    end

    def previously_matched(users, matches, is_match, count)
      matches.each do |match|
        if count < users.length
          if match.first_user_id == users[0].id.to_s && match.second_user_id == users[count].id.to_s
            count += 1
            is_match = false
          end
        end
      end
      return is_match, count
    end

    def match_users(users, matches, count)
      is_match = false
      while is_match == false  && count < users.length do
        first_user_interests = (users[0].interests)
        second_user_interests = (users[count].interests)
        is_match = match_interests(first_user_interests, second_user_interests)
        if is_match
          match_before = previously_matched(users, matches, is_match, count)
          is_match = match_before[0]
          count = match_before[1]
        else
          count += 1
        end
      end
      return count
    end

    def mis_match(users, count)
      not_match = false
      if users[0].demographic.race != users[count].demographic.race || users[0].demographic.sex_or != users[count].demographic.sex_or || users[0].demographic.country != users[count].demographic.country || users[0].demographic.religion != users[count].demographic.religion || users[0].demographic.ses != users[count].demographic.ses
        not_match = true
      end
      return count, not_match
    end

    def make_match(users, count)
      Match.create([first_user_id: users[0].id, second_user_id: users[count].id])
      users.delete_at(count)
      users.delete_at(0)
    end

    def match_calls(users, matches, no_matches, count = 1)

      count = match_users(users, matches, count)

      if count >= users.length && users.length > 0
        no_matches.push(users[0])
        users.delete_at(0)
        match_calls(users, matches, no_matches)
      end

      if count < users.length
        demo_match = mis_match(users, count)
        count = demo_match[0]
        not_match = demo_match[1]
      end

      if users.length >= 2 && count < users.length
        make_match(users, count)
      end

      return no_matches

    end

    def create_non_matched_matches(no_matches)
      while no_matches.length > 1
        Match.create([first_user_id: no_matches[0].id, second_user_id: no_matches[1].id])
        no_matches.delete_at(0)
        no_matches.delete_at(0)
      end
    end

    users = []
    User.all.each do |user|
      users.push(user)
    end

    matches = []
    Match.all.each do |match|
      matches.push(match)
    end

    no_matches = []

    while users.length >= 3 do
      no_matches = match_calls(users, matches, no_matches)
    end

    if users.length >= 2
      Match.create([first_user_id: users[0].id, second_user_id: users[1].id])
    end

    create_non_matched_matches(no_matches)

  end

end