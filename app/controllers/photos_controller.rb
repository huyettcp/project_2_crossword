class PhotosController < ApplicationController
  
  def index
    @photos = Photo.all
    @word_url = []

    @photos.each do |photo|
      @word_url << {word: photo.word.name, url: photo.url}
    end

    render json: @word_url
  end

end
