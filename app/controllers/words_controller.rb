class WordsController < ApplicationController
  
  def index
      @words = Word.all
      @words_array = []

      @words.each do |word_obj|
        words_list = {word: word_obj.name, photos: word_obj.photos}
  end
  
  end

  def show
      @words = Word.all
      @words_array = []

      @words.each do |word_obj|
        @photo_urls = []
        word_obj.photos.each do |photo|
          @photo_urls << photo.url
        end
        @words_array << {word: word_obj.name, photos: @photo_urls}
    end
    render json: @words_array
  end
end
 

