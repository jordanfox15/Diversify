class Api::InterestsController < ApplicationController

  def index
    @interests = Interest.all
    respond_to do |format|
      format.json {render json: @interests}
    end
  end

end
