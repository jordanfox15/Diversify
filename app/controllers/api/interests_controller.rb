class Api::InterestsController < ApplicationController

  def index
    @interests = Interest.all
    p render json: @interests
  end

end
