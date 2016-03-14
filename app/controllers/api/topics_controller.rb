class Api::TopicsController < ApplicationController

  def index
    @topic = Topic.find(rand(0..15))
    render json: @topic
  end

end
