class Api::TopicsController < ApplicationController

  def index
    @topic = Topic.find(rand(31..45))
    render json: @topic
  end

end
