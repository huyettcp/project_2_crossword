class Photo < ActiveRecord::Base
  attr_accessible :url
  belongs_to :word
end
