

describe Word do 
  it { validate_presence_of(:name) }
  it { should allow_value("coffee").for(:name) }
  it { validate_presence_of(:photo_id) }
  it { should have_many(:photos) }
end

 

