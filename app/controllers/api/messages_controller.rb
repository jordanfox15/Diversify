class Api::MessagesController < ApplicationController

  def index
    @match = Match.find(params[:match_id])
    @messages = @match.messages
      render json: @messages, :include => [:recipient, :sender]
  end

  def create
    @message = Message.new(message_params)
    @message.save
      render json: {match: @match, messages: @messages}
  end

  def topic
    @topic = Topic.find(rand(31..45)).name
    p @topic
    render json: @topic
  end

  private

  def message_params
    params.require(:message).permit(:text, :sender_id, :recipient_id, :unread, :match_id)
  end

end
