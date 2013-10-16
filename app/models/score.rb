class Score < ActiveRecord::Base
  attr_accessible :game_score, :user_name
  belongs_to :user
end
