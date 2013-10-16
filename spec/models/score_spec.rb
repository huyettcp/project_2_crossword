describe Score do 
  it { validate_presence_of(:game_score) }
  it { validate_presence_of(:user_name) }
  it { should allow_value(12).for(:game_score) }
  it { should allow_value("Spider-Man").for(:user_name) }
  it { validate_presence_of(:user_id) }
  it { should belong_to(:user) }
end
