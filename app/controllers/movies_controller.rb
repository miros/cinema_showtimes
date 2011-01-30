class MoviesController < ApplicationController

  def index

    @movies = Movie.actual


    @movies = case params[:order]
      when 'by_name'
        @movies.all_by_name
      when 'by_popularity'
        @movies.all_by_popularity
      when 'by_screens'
        @movies.all_by_screens
      else
        @movies.all_by_screens
    end

    @movies = @movies.unseen(current_user) if logged_in?
    @movies = @movies.premieres if params[:premieres]
    @movies = @movies.in_3d if params[:in_3d]

    respond_to do |format|
      format.html
      format.json { render :json => @movies }
    end

  end

  before_filter :find_movie, :except => :index

  def show

    @date = (params[:date] == 'today') ? Date.today : params[:date].to_date
    @shows = @movie.search(params.merge(:date => @date), current_user)

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
