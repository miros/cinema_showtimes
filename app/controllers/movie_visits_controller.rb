class MovieVisitsController < ApplicationController


  def index
    @movie_visits = current_user.movie_visits
  end

  def new
    @movie_visit = MovieVisit.new
    @movie_visit.movie_id = params[:movie] if params[:movie]
  end

  def edit
    @movie_visit = MovieVisit.find(params[:id])
  end

  def create
    @movie_visit = MovieVisit.new(params[:movie_visit])
    @movie_visit.user = current_user

    if @movie_visit.save
      redirect_to(movie_visits_path(), :notice => 'MovieVisit was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @movie_visit = MovieVisit.find(params[:id])

    if @movie_visit.update_attributes(params[:movie_visit])
      redirect_to(movie_visits_path(), :notice => 'MovieVisit was successfully updated.')
    else
      render :action => "edit"
    end

  end

  def destroy
    @movie_visit = MovieVisit.find(params[:id])
    @movie_visit.destroy
    redirect_to(movie_visits_url)
  end

end
