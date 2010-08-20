class FavouriteCinemasController < ApplicationController


  before_filter :login_required

  def index
    @favourite_cinemas = current_user.favourite_cinemas.ordered_by_name
  end

  def create

    render :text => 'Only Post request allowed' if !request.post?

    @favourite_cinema = FavouriteCinema.new
    @favourite_cinema.user = current_user

    begin
      cinema = Cinema.find(params[:cinema_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to_index(:alert => 'Ошибка! Кинотеатр не найден!')
      return
    end

    @favourite_cinema.cinema = cinema

    if @favourite_cinema.save
      redirect_to_index(:notice => 'Кинотеатр добавлен в любимые!')
    else
      redirect_to_index(:alert => 'Ошибка при добавлении кинотеатры в любимые!')
    end
  end

  def destroy
    @favourite_cinema = FavouriteCinema.find(params[:id])
    @favourite_cinema.destroy
    redirect_to favourite_cinemas_url
  end

  private

    def redirect_to_index(params)
      redirect_to({:action => :index}, params)
    end


end
