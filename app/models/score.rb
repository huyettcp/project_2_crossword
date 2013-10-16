class Score < ActiveRecord::Base
  attr_accessible :game_score
  belongs_to :user
end
