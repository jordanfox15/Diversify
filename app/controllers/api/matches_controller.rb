class Api::MatchesController < ApplicationController

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

  def create_match
    users = []
    first_user_interests = []
    second_user_interests = []
    first_user_demos = []
    second_user_demos = []
    User.all.each do |user|
      users.push(user.id)
    end
    (users.length \ 2).times do |i|
      first_user_interests.push(User.find(users[0]).interests)

  end

  def match_params
    params.require(:match).permit(:first_user_id, :second_user_id)
  end
end
