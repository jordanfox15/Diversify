class SessionsController < ApplicationController

  def create
    @user = User.find_by_email(params[:email])
    if @user.password == params[:password]
      session[:id] = @user.id
      respond_to do |format|
        format.json {render json: session}
      end
    else
      # redirect_to home_url
    end
  end

  def destroy
    session.delete[:id]
    respond_to do |format|
      format.json
    end
  end
end
