require 'spec_helper'

describe Movie, 'Search' do

  before(:each) do
    @movie = Movie.new()

    @shows_scope = mock('shows scope')
    @shows_scope.stub(:for_date).and_return(@shows_scope)
    
    @movie.stub_chain(:shows, :by_date).and_return(@shows_scope)

    @time_now = Time.now
    Time.stub!(:now).and_return(@time_now)

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

  it "should accept poorly formatted time" do
   @shows_scope.should_receive(:in_interval).with(Time.parse('16:00'), Time.parse('18:00')).and_return(@shows_scope)
   @movie.search(:from => '16', :to => '18')
  end
  
  def should_search_for_time(params) 
    from = (params[:from]) ? Time.parse(params[:from]) : Time.now
    to = (params[:to]) ? Time.parse(params[:to]) : Time.now.end_of_day
    @shows_scope.should_receive(:in_interval).with(from, to).and_return(@shows_scope)
    @movie.search(params)
  end

end
