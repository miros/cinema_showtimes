require 'spec_helper'

describe Show do

  before(:each) do
    @show = Show.new(:time => DateTime.new(2010, 01, 01, 12, 50))
  end

  it "should format showtime correctly" do
    @show.time_formatted.should == '12:50 (01-01-2010)'
  end

end
