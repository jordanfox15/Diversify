class Api::TopicsController < ApplicationController

  def index
    @topic = Topic.find(rand((Topic.first.id)..(Topic.last.id)))
    render json: @topic
  end

end
