class MoviesController < ApplicationController

  def index

    # @TODO make implementation of ordering that can be tested. find other ways of doing it

    @movies = Movie.all_by_popularity

    respond_to do |format|
      format.html
      format.json { render :json => @movies }
    end

  end

  before_filter :find_movie, :except => :index

  def show

    @shows = @movie.search(params)

    respond_to do |format|
      format.html
      format.json { render :json => @movie }
    end

  end

  private
  
    def find_movie
      @movie = Movie.find(params[:id])
    end

end
