class MoviesController < ApplicationController

  def index

    @movies = Movie.all_by_popularity

    respond_to do |format|
      format.html
      format.json { render :json => @movies }
    end

  end

  before_filter :find_movie, :except => :index

  def show

    @shows = @movie.search(params, current_user).with_cinemas

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
