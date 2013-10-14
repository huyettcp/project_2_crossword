require 'spec_helper'

# describe Photo do
#   before :each do 
#     @photo = Photo.new(url: "http://www.flickr.com/")
#   end

#   describe "#url" do
#     it "should return the correct url" do
#        @photo.url.should eq("http://www.flickr.com/")
#     end
#   end

# end

describe Photo do 
   it { should belong_to(:word) }
   it { validate_presence_of(:url) }
   it { should allow_value("https://www.google.com/").for(:url) }
end

