require 'spec_helper'

describe Movie, 'Search shows behaviour' do

  before(:each) do
    @movie = Movie.new()

    @shows_scope = mock('shows scope')
    @shows_scope.stub(:for_date).and_return(@shows_scope)
    
    @movie.stub_chain(:shows, :by_date).and_return(@shows_scope)
  end

  it "should search actual shows" do
    @shows_scope.should_receive(:actual).and_return(@shows_scope)
    @movie.search({:actual => true})
  end

  it "should search shows for date" do
    date = Date.new(2010, 10, 10)
    @shows_scope.should_receive(:for_date).with(date).and_return(@shows_scope)
    @movie.search({:date => '10-10-2010'})
  end

  it "should search shows for today by default" do
    @shows_scope.should_receive(:for_date).with(Date.today).and_return(@shows_scope)
    @movie.search({})
  end

  it "should search shows for tomorrow" do
    @shows_scope.should_receive(:for_date).with(Date.tomorrow).and_return(@shows_scope)
    @movie.search({:date => 'tomorrow'})
  end

  it "should filter shows for time (from, to)" do
   should_search_for_time :from => '12:00', :to => '14:00'
  end

  it "should filter shows for time (from)" do
    should_search_for_time :from => '12:00'
  end

  it "should filter shows for time (to)" do
    should_search_for_time :to => '14:00'
  end

  def should_search_for_time(params) 
    @shows_scope.should_receive(:in_interval).with(params).and_return(@shows_scope)
    @movie.search(params)
  end

end
