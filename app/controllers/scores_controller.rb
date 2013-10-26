class ScoresController < ApplicationController

  def index
    @high_scores = Score.all.sort { |p2, p1| p1.game_score <=> p2.game_score }
    respond_to do |format|
      format.html
      format.json {render :json => @high_scores}
    end
  end

  def create
    score = Score.new(params[:score])
    if score.save!
      render :json => score
    else
      render :json => false
    end
  end

end

#@high_scores = Score.where(:user_name => "Chip")
#Score.all.sort { |p1, p2| p1.game_score <=> p2.game_score }