class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.json {render json: @user}
    end
  end

  def create
    @user = User.new(params[:user])
    @user.password = params[:password]
    if @user.save
      session[:id] = @user.id
      respond_to do |format|
        format.json {render json: @user}
      end
    else
      respond_to do |format|
        format.json
      end
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(params)
    respond_to do |format|
      format.json {render json: @user}
    end
  end

  def destroy
    User.find(params[:id]).destroy
  end

end
