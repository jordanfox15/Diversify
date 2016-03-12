class Api::MessagesController < ApplicationController

  def index
    @match = Match.find(params[:match_id])
    @messages = @match.messages
      render json: {match: @match, messages: @messages}
  end

  def create
    @message = Message.new(message_params)
      render json: {match: @match, messages: @messages}
  end

  private
  
  def message_params
    params.require(:message).permit(:text, :sender_id, :recipient_id, :unread, :match_id)
  end

end
