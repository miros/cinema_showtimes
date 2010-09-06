require 'spec_helper'

describe MovieVisitsController do

  def mock_movie_visit(stubs={})
    @mock_movie_visit ||= mock_model(MovieVisit, stubs)
  end

  describe "GET index" do
    it "assigns all movie_visits as @movie_visits" do
      MovieVisit.stub(:find).with(:all).and_return([mock_movie_visit])
      get :index
      assigns[:movie_visits].should == [mock_movie_visit]
    end
  end

  describe "GET show" do
    it "assigns the requested movie_visit as @movie_visit" do
      MovieVisit.stub(:find).with("37").and_return(mock_movie_visit)
      get :show, :id => "37"
      assigns[:movie_visit].should equal(mock_movie_visit)
    end
  end

  describe "GET new" do
    it "assigns a new movie_visit as @movie_visit" do
      MovieVisit.stub(:new).and_return(mock_movie_visit)
      get :new
      assigns[:movie_visit].should equal(mock_movie_visit)
    end
  end

  describe "GET edit" do
    it "assigns the requested movie_visit as @movie_visit" do
      MovieVisit.stub(:find).with("37").and_return(mock_movie_visit)
      get :edit, :id => "37"
      assigns[:movie_visit].should equal(mock_movie_visit)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created movie_visit as @movie_visit" do
        MovieVisit.stub(:new).with({'these' => 'params'}).and_return(mock_movie_visit(:save => true))
        post :create, :movie_visit => {:these => 'params'}
        assigns[:movie_visit].should equal(mock_movie_visit)
      end

      it "redirects to the created movie_visit" do
        MovieVisit.stub(:new).and_return(mock_movie_visit(:save => true))
        post :create, :movie_visit => {}
        response.should redirect_to(movie_visit_url(mock_movie_visit))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved movie_visit as @movie_visit" do
        MovieVisit.stub(:new).with({'these' => 'params'}).and_return(mock_movie_visit(:save => false))
        post :create, :movie_visit => {:these => 'params'}
        assigns[:movie_visit].should equal(mock_movie_visit)
      end

      it "re-renders the 'new' template" do
        MovieVisit.stub(:new).and_return(mock_movie_visit(:save => false))
        post :create, :movie_visit => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested movie_visit" do
        MovieVisit.should_receive(:find).with("37").and_return(mock_movie_visit)
        mock_movie_visit.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :movie_visit => {:these => 'params'}
      end

      it "assigns the requested movie_visit as @movie_visit" do
        MovieVisit.stub(:find).and_return(mock_movie_visit(:update_attributes => true))
        put :update, :id => "1"
        assigns[:movie_visit].should equal(mock_movie_visit)
      end

      it "redirects to the movie_visit" do
        MovieVisit.stub(:find).and_return(mock_movie_visit(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(movie_visit_url(mock_movie_visit))
      end
    end

    describe "with invalid params" do
      it "updates the requested movie_visit" do
        MovieVisit.should_receive(:find).with("37").and_return(mock_movie_visit)
        mock_movie_visit.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :movie_visit => {:these => 'params'}
      end

      it "assigns the movie_visit as @movie_visit" do
        MovieVisit.stub(:find).and_return(mock_movie_visit(:update_attributes => false))
        put :update, :id => "1"
        assigns[:movie_visit].should equal(mock_movie_visit)
      end

      it "re-renders the 'edit' template" do
        MovieVisit.stub(:find).and_return(mock_movie_visit(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested movie_visit" do
      MovieVisit.should_receive(:find).with("37").and_return(mock_movie_visit)
      mock_movie_visit.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the movie_visits list" do
      MovieVisit.stub(:find).and_return(mock_movie_visit(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(movie_visits_url)
    end
  end

end
