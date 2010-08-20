require 'spec_helper'

describe FavouriteCinemasController do

  integrate_views

  def mock_favourite_cinema(stubs={})
    @mock_favourite_cinema ||= mock_model(FavouriteCinema, stubs.merge(:null_object => true))
  end

  before(:each) do
    @user = mock_model(User, :username => 'test user')
    @cinema = mock_model(Cinema, :name => 'test cinema')
    @favourite_cinema = mock_model(FavouriteCinema, :cinema => @cinema)
    @scope = mock('favourite_cinemas named scope', :ordered_by_name => [@favourite_cinema])
    @user.stub(:favourite_cinemas).and_return(@scope)   
    controller.stub(:current_user).and_return(@user)
  end

  describe "GET index" do
    it "assigns all users favourite_cinemas as @favourite_cinemas" do
      @user.should_receive(:favourite_cinemas).and_return(@scope)
      get :index
      assigns[:favourite_cinemas].should == [@favourite_cinema]
    end

    it "orders favourite cinemas by cinema name" do
      @scope.should_receive(:ordered_by_name).and_return([@favourite_cinema])
      get :index
    end

  end
  

  describe "POST create" do


    before(:each) do
      Cinema.stub(:find).and_return(@cinema) 
    end

    describe "with logged out user" do

      it 'should restrict access' do
        controller.stub(:current_user).and_return(nil)  
        post :create
        response.should redirect_to(login_url)
      end

    end

    describe "with valid params" do

      it "assigns a newly created favourite_cinema as @favourite_cinema" do
        FavouriteCinema.stub(:new).and_return(mock_favourite_cinema(:save => true))
        post :create, :cinema_id => 1
        assigns[:favourite_cinema].should equal(mock_favourite_cinema)
      end

      it "assign correct params to created favourite_cinema" do
        FavouriteCinema.stub(:new).and_return(mock_favourite_cinema(:save => true))
        mock_favourite_cinema.cinema.should = @cinema
        mock_favourite_cinema.user.should = @user
        post :create, :cinema_id => 1
      end

      it "redirects to the favourite_cinema index page" do
        FavouriteCinema.stub(:new).and_return(mock_favourite_cinema(:save => true))
        post :create, :cinema_id => 1
        response.should redirect_to(favourite_cinemas_url)
        flash[:notice].should_not be_blank
      end
    end

    describe "with invalid params" do

      it "assigns a newly created but unsaved favourite_cinema as @favourite_cinema" do
        FavouriteCinema.stub(:new).and_return(mock_favourite_cinema(:save => false))
        post :create, :cinema_id => 1
        assigns[:favourite_cinema].should equal(mock_favourite_cinema)
      end

      it "redirects to the favourite_cinema index page with error flash message" do
        FavouriteCinema.stub(:new).and_return(mock_favourite_cinema(:save => false))
        post :create, :cinema_id => 1
        response.should redirect_to(favourite_cinemas_url)
        flash[:alert].should match(/Ошибка/)
      end


      it "redirects and shows flash error when given invalid cinema_id" do
        Cinema.stub(:find).and_raise(ActiveRecord::RecordNotFound)
        post :create, :cinema_id => 'wrong_id'
        response.should redirect_to(favourite_cinemas_url)
        flash[:alert].should match(/Ошибка/)
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

end
