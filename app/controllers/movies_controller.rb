class MoviesController < ApplicationController

  def index

    # @TODO make implementation of ordering that can be tested. find other ways of doing it

    @movies = Movie.ordered_by_popularity

    respond_to do |format|
      format.html
      format.json { render :json => @movies }
    end

  end


  def show



  end

end
