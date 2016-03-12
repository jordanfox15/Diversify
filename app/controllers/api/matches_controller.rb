class Api::MatchesController < ApplicationController

  def index
    @user = User.find(session[:id])
    @matches = @user.first_user_matches + @user.second_user_matches
      render json: [@user, @matches]
  end

  def show
    @user = User.find(session[:id])
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

  private

  def match_params
    params.require(:match).permit(:first_user_id, :second_user_id)
  end
end
