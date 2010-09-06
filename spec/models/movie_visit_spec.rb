require 'spec_helper'

describe MovieVisit do
  before(:each) do
    @valid_attributes = {
      :user_id => 1,
      :movie_id => 1,
      :cinema_id => 1,
      :time => Time.now
    }
  end

  it "should create a new instance given valid attributes" do
    MovieVisit.create!(@valid_attributes)
  end
end
