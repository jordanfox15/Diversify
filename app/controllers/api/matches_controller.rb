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

  def match_interests(first_matches, second_matches, count = 0)
    if first_matches.include?(second_matches[count])
      return true
    elsif count == (second_matches.length - 1)
      return false
    else
      match_interests(first_matches, second_matches, count + 1)
    end
  end

  def create_match
    users = []
    User.all.each do |user|
      users.push(user)
    end

    ((users.length / 2) - 1).times do

      is_match = false
      count = 1

      while is_match == false  && count < users.length do
        first_user_interests = (users[0].interests)
        second_user_interests = (users[count].interests)
        is_match = match_interests(first_user_interests, second_user_interests)
        if is_match == false
          count += 1
        end
      end

      not_match = false
      while not_match == false
        if users[0].race != users[count].race || users[0].sex_or != users[count].sex_or || users[0].country != users[count].country || users[0].religion != users[count].religion || users[0].ses != users[count].ses
          not_match = true
        else
          p "no mis-match"
        end
      end

      if is_match == true && not_match == true
        Match.create([first_user_id: users[0].id, second_user_id: users[count].id])
        users.delete_at(0)
        users.delete_at(count - 1)
      else
        p "no total match"
      end

      if users.length <= 3
        Match.create([first_user_id: users[0].id, second_user_id: users[1].id])
      end

    end
  end

  def match_params
    params.require(:match).permit(:first_user_id, :second_user_id)
  end
end
