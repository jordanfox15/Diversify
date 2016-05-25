require 'authtoken'
class Api::SessionsController < ApplicationController

  skip_before_action :authenticate

  def create
    if user = Session.authenticate(params[:email], params[:password])
      token = AuthToken.issue(user_id: user.id)
      $redis.hset(token, 'user_id', user.id)
      $redis.expire(token, 60.minutes.to_i)
      render json: {user: user, token: token}
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def destroy
    $redis.del(current_token)
    render nothing: true, status: :ok, content_type: 'application/json'
  end

end
