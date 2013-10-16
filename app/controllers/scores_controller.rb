class ScoresController < ApplicationController
 def create
  score = Score.new(params[:score])
  if score.save!
    render :json => score
  else
    render :json => false
  end
end


end