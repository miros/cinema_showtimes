require 'spec_helper'

describe CinemasController do

  integrate_views

  # @TODO refactor all this test crap

  describe "GET 'cinemas'" do
    it "should be successful" do

      cinema = mock_model(Cinema, :id => 1, :name => 'test_cinema_name')
      Cinema.should_receive(:find).with(:all, {:order=>"name ASC"}).and_return([cinema])

      get 'index'
      response.should be_success
      response.should include_text '1'
      response.should include_text 'test_cinema_name'

    end
  end

  describe "GET 'cinemas/1'" do
    it "should be successful" do

      cinema = mock_model(Cinema, :id => 1, :name => 'test_cinema_name', :city => 'москва')
      show = mock_model(Show, :time => '12:00')
      movie = mock_model(Movie, :name => 'test_movie_name')

      cinema.should_receive(:shows).and_return([show])
      show.should_receive(:movie).and_return(movie)

      Cinema.should_receive(:find).with('1').and_return(cinema)

      get 'show', {:id => '1'}

      response.should be_success

      response.should include_text '1'
      response.should include_text 'test_cinema_name'
      response.should include_text 'москва'
      response.should include_text 'test_movie_name'
      response.should include_text '12:00'

    end
  end


end
