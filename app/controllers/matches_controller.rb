class MatchesController < ApplicationController

  def index
    @user = User.find(session[:id])
    @matches = @user.matches
    respond_to do |format|
      format.json {render json: [@user, @matches]}
    end
  end

  def show
    @user = User.find(session[:id])
    @match = Match.find(params[:id])
    respond_to do |format|
      format.json {render json: [@user, @match]}
    end
  end

  def create
    @match = Match.new(params)
    respond_to do |format|
      format.json {render json: @match}
    end
  end

end
