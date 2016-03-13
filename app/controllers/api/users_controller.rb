class Api::UsersController < ApplicationController

  def profile
    @user = current_user
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save!
      render json: @user
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
    params.require(:user).permit(:first_name, :last_name, :ethnicity, :email, :password, :password_confirmation, :religion, :sex_or, :ses, :country, :gender, :age)
  end


end
