class Word < ActiveRecord::Base
  attr_accessible :image_url, :name
  has_many :photos
end
