require 'spec_helper'

describe FavouriteCinemasController do

# @TODO examine and uncomment

=begin
  def mock_favourite_cinema(stubs={})
    @mock_favourite_cinema ||= mock_model(FavouriteCinema, stubs)
  end

  describe "GET index" do
    it "assigns all favourite_cinemas as @favourite_cinemas" do
      FavouriteCinema.stub(:find).with(:all).and_return([mock_favourite_cinema])
      get :index
      assigns[:favourite_cinemas].should == [mock_favourite_cinema]
    end
  end

  describe "GET show" do
    it "assigns the requested favourite_cinema as @favourite_cinema" do
      FavouriteCinema.stub(:find).with("37").and_return(mock_favourite_cinema)
      get :show, :id => "37"
      assigns[:favourite_cinema].should equal(mock_favourite_cinema)
    end
  end

  describe "GET new" do
    it "assigns a new favourite_cinema as @favourite_cinema" do
      FavouriteCinema.stub(:new).and_return(mock_favourite_cinema)
      get :new
      assigns[:favourite_cinema].should equal(mock_favourite_cinema)
    end
  end

  describe "GET edit" do
    it "assigns the requested favourite_cinema as @favourite_cinema" do
      FavouriteCinema.stub(:find).with("37").and_return(mock_favourite_cinema)
      get :edit, :id => "37"
      assigns[:favourite_cinema].should equal(mock_favourite_cinema)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created favourite_cinema as @favourite_cinema" do
        FavouriteCinema.stub(:new).with({'these' => 'params'}).and_return(mock_favourite_cinema(:save => true))
        post :create, :favourite_cinema => {:these => 'params'}
        assigns[:favourite_cinema].should equal(mock_favourite_cinema)
      end

      it "redirects to the created favourite_cinema" do
        FavouriteCinema.stub(:new).and_return(mock_favourite_cinema(:save => true))
        post :create, :favourite_cinema => {}
        response.should redirect_to(favourite_cinema_url(mock_favourite_cinema))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved favourite_cinema as @favourite_cinema" do
        FavouriteCinema.stub(:new).with({'these' => 'params'}).and_return(mock_favourite_cinema(:save => false))
        post :create, :favourite_cinema => {:these => 'params'}
        assigns[:favourite_cinema].should equal(mock_favourite_cinema)
      end

      it "re-renders the 'new' template" do
        FavouriteCinema.stub(:new).and_return(mock_favourite_cinema(:save => false))
        post :create, :favourite_cinema => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested favourite_cinema" do
        FavouriteCinema.should_receive(:find).with("37").and_return(mock_favourite_cinema)
        mock_favourite_cinema.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :favourite_cinema => {:these => 'params'}
      end

      it "assigns the requested favourite_cinema as @favourite_cinema" do
        FavouriteCinema.stub(:find).and_return(mock_favourite_cinema(:update_attributes => true))
        put :update, :id => "1"
        assigns[:favourite_cinema].should equal(mock_favourite_cinema)
      end

      it "redirects to the favourite_cinema" do
        FavouriteCinema.stub(:find).and_return(mock_favourite_cinema(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(favourite_cinema_url(mock_favourite_cinema))
      end
    end

    describe "with invalid params" do
      it "updates the requested favourite_cinema" do
        FavouriteCinema.should_receive(:find).with("37").and_return(mock_favourite_cinema)
        mock_favourite_cinema.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :favourite_cinema => {:these => 'params'}
      end

      it "assigns the favourite_cinema as @favourite_cinema" do
        FavouriteCinema.stub(:find).and_return(mock_favourite_cinema(:update_attributes => false))
        put :update, :id => "1"
        assigns[:favourite_cinema].should equal(mock_favourite_cinema)
      end

      it "re-renders the 'edit' template" do
        FavouriteCinema.stub(:find).and_return(mock_favourite_cinema(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested favourite_cinema" do
      FavouriteCinema.should_receive(:find).with("37").and_return(mock_favourite_cinema)
      mock_favourite_cinema.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the favourite_cinemas list" do
      FavouriteCinema.stub(:find).and_return(mock_favourite_cinema(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(favourite_cinemas_url)
    end
  end
=end

end
