require 'spec_helper'

describe MoviesController do

  integrate_views

  describe "get /movies" do

    before(:each) do
      
      @movie = mock_model(Movie, :id => 1, :name => 'test_movie')
      Movie.should_receive(:find).and_return([@movie])
      get 'index'
    end

    it "should be success" do
      response.should be_success
    end

    it "should show movie names" do
      response.should have_tag('span.movie_name', @movie.name)
    end

  end

end
