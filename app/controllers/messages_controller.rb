class MessagesController < ApplicationController

  def index
    @match = Match.find(params[:match_id])
    @messages = @match.messages
    respond_to do |format|
      format.json {render json: [@match, @messages]}
    end
  end

  def create
    @match = Match.find(params[:match_id])
    @message = Message.new(params[text: text, sender_id: sender_id, recipient_id: recipient_id, match_id: @match.id])
    respond_to do |format|
      format.json {render json: [@match, @message]}
    end
  end

end
