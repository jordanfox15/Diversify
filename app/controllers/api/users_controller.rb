require 'authtoken'
class Api::UsersController < ApplicationController
  skip_before_action :authenticate, only: :create

  def profile
    @user = current_user
    render json: @user, :include => [:interests, :demographic, :religion, :sex_or, :ses, :country, :gender, :race]
  end

  def profile_picture
    @user = current_user
    render json: {url: @user.avatar.url(:thumb)}
  end

  def edit_profile
    @user = current_user
      @user.update(user_params)
    render json: @user
  end

  def interests
    @user = User.find(params[:id])
    render json: @user.interest_ids
  end

  def create
    @user = User.new(user_params)
    if @user.save!
      demographic = Demographic.new
      @user.demographic = demographic
      token = AuthToken.issue(user_id: @user.id)
      $redis.hset(token, 'user_id', @user.id)
      $redis.expire(token, 60.minutes.to_i)
      render json: {user: @user, token: token}
      h=JSON.generate({'email' => params[:email]})
      PostmanWorker.perform_async(h,5)
    else
      render json: @user.errors
    end
  end


  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    render json: @user
  end

  def destroy
    User.find(params[:id]).destroy
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :race, :email, :religion, :sex_or, :ses, :country, :gender, :age, :avatar, :password, :password_confirmation, :interest_ids => [] )
  end


end
