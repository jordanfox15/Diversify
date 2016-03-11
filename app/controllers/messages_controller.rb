class MessagesController < ApplicationController

  def index
    @match = Match.find(params[:id])
    @messages = @match.messages
    respond_to do |format|

  end

end
