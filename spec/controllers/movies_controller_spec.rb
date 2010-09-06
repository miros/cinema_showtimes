require 'spec_helper'

describe MoviesController do

  integrate_views

  describe "get /movies/" do

    before(:each) do
      @movie = mock_model(Movie, :id => 1, :name => 'test_movie', :null_object => true)
      @movies = [@movie]
      @movies.stub!(:unseen).and_return(@movies)
    end

    describe "order by name" do

      it "should be success" do
        Movie.should_receive(:all_by_name).and_return(@movies)
        get :index, :order => 'by_name'
        puts [@movie]
        response.should be_success
        response.should have_tag('span.movie_name', @movie.name)
      end

    end

    describe "order by popularity" do

      it "should be success" do
        Movie.should_receive(:all_by_popularity).and_return(@movies)
        get :index, :order => 'by_popularity'
        response.should be_success
        response.should have_tag('span.movie_name', @movie.name)
      end

    end

  end

  describe "get /movies/:id" do

    before(:each) do
      @movie = mock_model(Movie, :name => 'test_movie', :null_object => true)
      Movie.should_receive(:find).and_return(@movie)

      @cinema = mock_model(Cinema, :name => 'test_cinema_name')
      @show = mock_model(Show, :time => Time.local(2010, 01, 01, 12, 50), :cinema => @cinema, :time_formatted => '12:50', :null_object => true)

      @movie.stub(:search).and_return(@shows = [@show.clone, @show.clone, @show.clone])
      @movie.should_receive(:search).and_return(@shows)


    end

    # !TODO REFACTOR THIS!

    it "should show movie shows for today" do
      get 'show', {:id => '1', :date => 'today'}
      response.should be_success
    end

    it "should show movie shows for date" do
      get_for_date Date.today.to_s
      response.should be_success
    end

    it "should show movie name" do
      get_for_date
      response.should have_tag('h1.movie_name', @movie.name)
    end

     it "should display all shows" do
      get_for_date
      assigns[:shows].should have(3).shows
    end

    def get_for_date(date = 'today')
      get 'show', {:id => '1', :date => date}
    end

  end


end
