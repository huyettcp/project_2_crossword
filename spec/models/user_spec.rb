require 'spec_helper'

describe User do 
  it { validate_presence_of(:name) }
  it { should allow_value("Chip").for(:name) }
  it { should have_many(:scores) }
end
