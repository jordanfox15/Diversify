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
      if users[0].race != users[count].race || users[0].sex_or != users[count].sex_or || users[0].country != users[count].country || users[0].religion != users[count].religion || users[0].ses != users[count].ses
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

    def create_match_emails

      user_emails = ""
      recent_matches = ""
      User.all.each do |user|
        recent_match = []
        recent_match.push(user.first_user_matches.last)
        recent_match.push(user.second_user_matches.last)
        recent_match.compact!

        if recent_match.length > 0
          user_emails += (user.email + " ")

          if recent_match.length > 1
            recent_match.sort! {|x, y| y.created_at <=> x.created_at}
          end

          if user.id.to_s == recent_match[0].first_user_id
            recent_matches += (User.find(recent_match[0].second_user_id).first_name + " " + User.find(recent_match[0].second_user_id).last_name + ".")
          else
            recent_matches += (User.find(recent_match[0].first_user_id).first_name + " " + User.find(recent_match[0].first_user_id).last_name + ".")
          end
        end
      end

      h = JSON.generate({'emails' => user_emails.chop, 'names' => recent_matches.chop})
      MatchMailWorker.perform_async(h, 5)

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
      users.delete_at(0)
      users.delete_at(0)
    end

    if users.length != 0
      no_matches.push(users[0])
    end

    create_non_matched_matches(no_matches)

    create_match_emails

  end

end
