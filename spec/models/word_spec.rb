# require 'spec_helper'

# describe Word do
#   before :each do 
#     @word = Word.new(name: "Beer")
#     @photo = Photo.new(url: "google")
#     @word.photos << @photo
#   end

#   describe "#name" do
#     it "should return the correct word" do
#        @word.name.should eq("Beer")
#     end

#     it "should reuturn a photo"
#       @word.photos.should eq(Photo)

#   end



# end

describe Word do 
  it { validate_presence_of(:name) }
  it { should allow_value("coffee").for(:name) }
  it { validate_presence_of(:photo_id) }
  it { should have_many(:photos) }
end

 

