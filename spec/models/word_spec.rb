require 'spec_helper'

describe Word do
  before :each do 
    @word = Word.new(name: "Beer")
    @photo = Photo.new(url: "google")
    @word.photos << @photo
  end

  describe "#name" do
    it "should return the correct word" do
       @word.name.should eq("Beer")
    end
  end

  #   it "should reuturn a photo"
  #     @word.photos.should eq(Photo)

  # end



end