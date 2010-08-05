
class CinemasController < ApplicationController
  def show
    @cinema = Cinema.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => @cinema.to_json(:include => {
              :shows => {
                :include => :movie        
              }
      }) }
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
