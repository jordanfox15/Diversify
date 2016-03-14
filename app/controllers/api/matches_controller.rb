class Api::MatchesController < ApplicationController

  skip_before_action :authenticate, only: :random

  def index
    @user = current_user
    @matches = @user.first_user_matches + @user.second_user_matches
      render json: [@user, @matches]
  end

  def show
    @user = current_user
    @match = Match.find(params[:id])
      render json: [@user, @match]
  end

#  Create action - Not needed for front end use
#  def create
#    @match = Match.new(match_params)
#     render json: @match
#  end

  def update
    @match = Match.find(params[:id])
    @match.topic_id = rand(1..(Topic.all.length + 1))
      render json: @match
  end

  def random
    create_match
  end

  private

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
      if match.first_user_id == users[0].id.to_s && match.second_user_id == users[count].id.to_s
        count += 1
        is_match = false
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
    return count, is_match
  end

  def mis_match(users, count)
    not_match = false
    if users[0].race != users[count].race || users[0].sex_or != users[count].sex_or || users[0].country != users[count].country || users[0].religion != users[count].religion || users[0].ses != users[count].ses
      not_match = true
    end
    return count, not_match
  end

  def make_match(users, count, is_match, not_match)
    if is_match == true && not_match == true
      Match.create([first_user_id: users[0].id, second_user_id: users[count].id])
      users.delete_at(0)
      users.delete_at(count - 1)
      return true
    else
      return false
    end
  end

  def match_calls(users, matches, count = 1)

    interest_match = match_users(users, matches, count)
    count = interest_match[0]
    is_match = interest_match[1]

    demo_match = mis_match(users, count)
    count = demo_match[0]
    not_match = demo_match[1]

    matched = make_match(users, count, is_match, not_match)

    if matched == false
      match_calls(users, count + 1)
    end
  end

  def create_match
    users = []
    User.all.each do |user|
      users.push(user)
    end

    matches = []
    Match.all.each do |match|
      matches.push(match)
    end

    ((users.length / 2) - 1).times do

      match_calls(users, matches)

      if users.length <= 3
        Match.create([first_user_id: users[0].id, second_user_id: users[1].id])
      end

    end
  end

  def match_params
    params.require(:match).permit(:first_user_id, :second_user_id)
  end
end
