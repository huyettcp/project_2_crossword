require 'spec_helper'

describe Word do
  before :each do 
    @word = Word.new(name: "Beer", image_url: "google")

   end




   describe "#name" do
     it "should return the correct word" do
       @word.name.should eq("Beer")
     end
   end
 end

#   describe "#image_url" do
#     it "should return the correct url" do
#       @name.image_url.should eq ("google")
#     end
#   end

# end