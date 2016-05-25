class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_action :authenticate

  protected

  def current_token
    @token || nil
  end

  def current_user
    @current_user ||= User.find($redis.hget(current_token, :user_id)) if current_token
  end

  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
      @token = nil
      if AuthToken.valid?(token) && $redis.ttl(token) > 0
        @token = token
        $redis.expire(token, 20.minutes.to_i) # set TTL as constant
      end
      @token
    end
  end

  def render_unauthorized
    self.headers['WWW-Authenticate'] = 'Token realm="Application"'
    render nothing: true, status: :unauthorized, content_type: 'application/json'
  end


end
