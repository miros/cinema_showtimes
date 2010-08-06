class MoviesController < ApplicationController

  def index

    # @TODO make implementation of ordering that can be tested

    @movies = Movie.all(:joins => :shows, :group => 'movies.id, movies.name', :order => 'count(shows.id) desc')

    respond_to do |format|
      format.html
      format.json { render :json => @movies }
    end

  end


  def show



  end

end
