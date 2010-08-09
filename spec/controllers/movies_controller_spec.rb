require 'spec_helper'

describe MoviesController do

  integrate_views

  describe "get /movies" do

    before(:each) do 
      @movie = mock_model(Movie, :id => 1, :name => 'test_movie')
      Movie.should_receive(:all_by_popularity).and_return([@movie])
      get 'index'
    end

    it "should be success" do
      response.should be_success
    end

    it "should show movie names" do
      response.should have_tag('span.movie_name', @movie.name)
    end

  end

  # @TODO REFACTOR  "get /movies/:id/actual" and "get /movies/:id"

  describe "get /movies/:id/actual" do

    before(:each) do
      @movie = mock_model(Movie, :id => 1, :name => 'test_movie')
      Movie.should_receive(:find).and_return(@movie)
      @movie.should_receive(:actual_shows).and_return([])

    end

    it "should be able to show actual showtimes" do
      get 'show', {:id => '1', :actual => true}
    end

  end


  describe "get /movies/:id" do

    before(:each) do
      @movie = mock_model(Movie, :id => 1, :name => 'test_movie')
      Movie.should_receive(:find).and_return(@movie)

      @cinema = mock_model(Cinema, :id => 1, :name => 'test_cinema_name', :city => 'москва')
      @show = mock_model(Show, :time => DateTime.new(2010, 01, 01, 12, 50), :cinema => @cinema)
      @show.should_receive(:time_formatted).at_least(:once).and_return('12:50 (01-01-2010)')

      @movie.stub(:shows).and_return(@shows = [@show.clone, @show.clone, @show.clone])
      @movie.should_receive(:all_shows).and_return(@shows)

      get 'show', {:id => '1'}
    end

    it "should be success" do
      response.should be_success
    end

    it "should show movie name" do
      response.should have_tag('h1.movie_name', @movie.name)
    end

    it "should display show time" do
      response.should have_tag('span.show_time', '12:50 (01-01-2010)')
    end

    it "should display all shows" do
      assigns[:movie].should have(3).shows
    end

  end

end
