
class CinemasController < ApplicationController
  def show
    @cinema = Cinema.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => @cinema }
    end

  end

  def index

    @cinemas = Cinema.find(:all, :order => 'name ASC')

    respond_to do |format|
      format.html
      format.json { render :json => @cinemas }
    end

  end

end
