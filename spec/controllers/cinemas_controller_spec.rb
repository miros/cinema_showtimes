require 'spec_helper'

describe CinemasController do

  integrate_views

  describe "GET /cinemas" do

    before(:each) do
      @cinema = mock_model(Cinema, :id => 1, :name => 'test_cinema_name')
      Cinema.should_receive(:find).with(:all, {:order=>"name ASC"}).and_return([@cinema])
      get 'index'
    end

    it "should be success" do
      response.should be_success
    end

    it "should show cinema names" do
      response.should have_tag('span.cinema_name', @cinema.name)
    end

  end

  describe "GET cinemas/:id" do

    def get_cinemas_show
      get 'show', {:id => '1'}
    end

    before(:each) do
      @cinema = mock_model(Cinema, :id => 1, :name => 'test_cinema_name', :city => 'москва')
      @movie = mock_model(Movie, :name => 'test_movie_name')
      @show = mock_model(Show, :time => DateTime.new(2010, 01, 01, 12, 50), :movie => @movie)
      @show.should_receive(:time_formatted).at_least(:once).and_return('12:50 (01-01-2010)')
      
      @cinema.should_receive(:shows).at_least(:once).and_return([@show, @show, @show])
      Cinema.should_receive(:find).with('1').and_return(@cinema)

      get_cinemas_show
    end

    it "should be success" do
       response.should be_success
    end

    it "should display cinema name" do
      response.should have_tag('h1', /#{@cinema.name}/)
    end

    it "should display show time correctly" do
      response.should have_tag('span.show_time', '12:50 (01-01-2010)')
    end

    it "should display all shows" do
      assigns[:cinema].should have(3).shows
    end

  end


end
