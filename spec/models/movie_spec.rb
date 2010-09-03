require 'spec_helper'
require 'ap'


describe Movie, 'Search' do

  before(:each) do
    @movie = Movie.new()

    @shows_scope = mock('shows scope')
    @shows_scope.stub(:for_date).and_return(@shows_scope)
    @shows_scope.stub(:actual).and_return(@shows_scope)
    @shows_scope.stub(:with_cinemas).and_return(@shows_scope)

    @movie.stub_chain(:shows, :ordered_by_date).and_return(@shows_scope)

    @time_now = Time.now.utc
    Time.stub!(:now).and_return(@time_now)
    Date.stub!(:today).and_return(@time_now.to_date)
    Date.stub!(:tomorrow).and_return(@time_now.to_date.tomorrow)

    @user = mock_model(User)

  end

  it "should include cinemas for shows" do
    @shows_scope.should_receive(:with_cinemas).and_return(@shows_scope)
    @movie.search({:date => Date.today})
  end

  it "should search actual shows if date is today" do
    @shows_scope.should_receive(:actual).and_return(@shows_scope)
    @movie.search({:date => Date.today})
  end

  it "should search shows for date" do
    date = Date.new(2010, 10, 10)
    @shows_scope.should_receive(:for_date).with(date).and_return(@shows_scope)
    @movie.search({:date => date})
  end

  it "should filter tomorrow shows for time (from, to)" do
    params = {:date => Date.tomorrow, :from => '12:00', :to => '14:00'}
    @shows_scope.should_receive(:for_date).with(Date.tomorrow).and_return(@shows_scope)
    check_time_limits(params, Date.tomorrow)
    @movie.search(params) 
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
   @movie.search(:date => Date.today, :from => '16', :to => '18')
  end
  
  def should_search_for_time(params)
    params = {:date => Date.today}.merge(params)
    check_time_limits(params, Date.today)
    @movie.search(params)
  end

  def check_time_limits(params, date = nil)
    from = (params[:from]) ? Time.parse(params[:from]) : Time.now
    to = (params[:to]) ? Time.parse(params[:to]) : Time.now.end_of_day

    if date
      from = date + from.hour.hours + from.min.minutes + from.sec.seconds
      to = date + to.hour.hours + to.min.minutes + to.sec.seconds
    end

    @shows_scope.should_receive(:in_interval).with(from, to).and_return(@shows_scope)
  end

  it 'should search movies in favourite cinemas' do
    @shows_scope.should_receive(:in_favourite_cinemas).with(@user).and_return(@shows_scope)
    @movie.search({:date => Date.today, :favourite_cinemas => true}, @user)
  end

   it 'should not search movies in favourite cinemas if user is not logged in' do
    @shows_scope.should_not_receive(:in_favourite_cinemas)
    @movie.search({:date => Date.today, :favourite_cinemas => true})
  end

end
