class Api::UsersController < ApplicationController
  skip_before_action :authenticate, only: :create

  def profile
    @user = current_user
    render json: @user, :include => :interests
  end

  def edit_profile
    @user = current_user
      @user.update(user_params)
    render json: @user
  end

  def interests
    @user = User.find(params[:id])
    render json: @user.interests
  end

  def create
    @user = User.new(user_params)
    @user.password = params[:password]
    @user.password_confirmation = params[:password_confirmation]
    if @user.save!
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
    params.require(:user).permit(:first_name, :last_name, :race, :email, :religion, :sex_or, :ses, :country, :gender, :age, :interest_ids => [])
  end


end
