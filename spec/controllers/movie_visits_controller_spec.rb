require 'spec_helper'

describe MovieVisitsController do

  def mock_movie_visit(stubs={})
    @mock_movie_visit ||= mock_model(MovieVisit, stubs.merge(:null_object => true))
  end

  def mock_movie_visits()
    @mock_movie_visits ||= []
  end

  before(:each) do
    @user = mock_model(User, :username => 'test user')
    controller.stub(:current_user).and_return(@user)
  end

  describe "GET index" do
    it "assigns all users movie_visits as @movie_visits" do
      @user.stub!(:movie_visits).and_return(mock_movie_visits)
      get :index
      assigns[:movie_visits].should == mock_movie_visits
    end
  end

  describe "GET new" do
    it "assigns a new movie_visit as @movie_visit" do
      MovieVisit.stub(:new).and_return(mock_movie_visit)
      get :new
      assigns[:movie_visit].should equal(mock_movie_visit)
    end

    it "should create movie_visit for given film" do
      MovieVisit.stub(:new).and_return(mock_movie_visit)
      get :new, :movie => 134
      assigns[:movie_visit].movie_id.should =137
    end

    it "should create movie_visit for current user" do
      MovieVisit.stub(:new).and_return(mock_movie_visit)
      get :new, :movie => 134
      assigns[:movie_visit].user.should =@user
    end

  end

  describe "GET edit" do
    it "assigns the requested movie_visit as @movie_visit" do
      @user.stub!(:movie_visits).and_return(mock_movie_visits)
      mock_movie_visits.stub(:find).with("37").and_return(mock_movie_visit)
      get :edit, :id => "37"
      assigns[:movie_visit].should equal(mock_movie_visit)
    end
  end

  describe "POST create" do


    describe "with logged out user" do

      it 'should restrict access' do
        controller.stub(:current_user).and_return(nil)
        post :create
        response.should redirect_to(login_url)
      end

    end

    describe "with valid params" do
      it "assigns a newly created movie_visit as @movie_visit" do
        MovieVisit.stub(:new).with({'these' => 'params'}).and_return(mock_movie_visit(:save => true))
        post :create, :movie_visit => {:these => 'params'}
        assigns[:movie_visit].should equal(mock_movie_visit)
      end

      it "redirects to the movie_visit index page" do
        MovieVisit.stub(:new).and_return(mock_movie_visit(:save => true))
        post :create, :movie_visit => {}
        response.should redirect_to(movie_visits_path)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved movie_visit as @movie_visit" do
        MovieVisit.stub(:new).with({'these' => 'params'}).and_return(mock_movie_visit(:save => false))
        post :create, :movie_visit => {:these => 'params'}
        assigns[:movie_visit].should equal(mock_movie_visit)
      end

      it "rerenders new template" do
        MovieVisit.stub(:new).and_return(mock_movie_visit(:save => false))
        post :create
        response.should render_template(:new)
      end

    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested movie_visit" do
        @user.stub!(:movie_visits).and_return(mock_movie_visits)
        mock_movie_visits.should_receive(:find).with("37").and_return(mock_movie_visit)
        mock_movie_visit.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :movie_visit => {:these => 'params'}
      end

      it "assigns the requested movie_visit as @movie_visit" do
        @user.stub!(:movie_visits).and_return(mock_movie_visits)
        mock_movie_visits.stub(:find).and_return(mock_movie_visit(:update_attributes => true))
        put :update, :id => "1"
        assigns[:movie_visit].should equal(mock_movie_visit)
      end

      it "redirects to the movie_visit index page" do
        @user.stub!(:movie_visits).and_return(mock_movie_visits)
        mock_movie_visits.stub(:find).and_return(mock_movie_visit(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(movie_visits_path)
      end
    end

    describe "with invalid params" do
      it "updates the requested movie_visit" do
        @user.stub!(:movie_visits).and_return(mock_movie_visits)
        mock_movie_visits.should_receive(:find).with("37").and_return(mock_movie_visit)
        mock_movie_visit.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :movie_visit => {:these => 'params'}
      end

      it "assigns the movie_visit as @movie_visit" do
        @user.stub!(:movie_visits).and_return(mock_movie_visits)
        mock_movie_visits.stub(:find).and_return(mock_movie_visit(:update_attributes => false))
        put :update, :id => "1"
        assigns[:movie_visit].should equal(mock_movie_visit)
      end

      it "re-renders the 'edit' template" do
        @user.stub!(:movie_visits).and_return(mock_movie_visits)
        mock_movie_visits.stub(:find).and_return(mock_movie_visit(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested movie_visit" do
      @user.stub!(:movie_visits).and_return(mock_movie_visits)
      mock_movie_visits.should_receive(:find).with("37").and_return(mock_movie_visit)
      mock_movie_visit.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the movie_visits list" do
      @user.stub!(:movie_visits).and_return(mock_movie_visits)
      mock_movie_visits.stub(:find).and_return(mock_movie_visit(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(movie_visits_url)
    end
  end

end
