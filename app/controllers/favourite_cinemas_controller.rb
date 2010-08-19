class FavouriteCinemasController < ApplicationController


  before_filter :login_required

  def index
    @favourite_cinemas = current_user.favourite_cinemas.all(:joins => :cinema, :order => 'cinemas.name ASC')
  end

  def create
    @favourite_cinema = FavouriteCinema.new
    @favourite_cinema.user = current_user
    @favourite_cinema.cinema = Cinema.find(params[:cinema_id])

    if @favourite_cinema.save
      redirect_to({:action => :index}, :notice => 'FavouriteCinema was successfully created.')
    else
      render :action => "new"
    end
  end

  def destroy
    @favourite_cinema = FavouriteCinema.find(params[:id])
    @favourite_cinema.destroy
    redirect_to favourite_cinemas_url
  end


end
