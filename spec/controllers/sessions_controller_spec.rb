require File.dirname(__FILE__) + '/../spec_helper'
 
describe SessionsController do
  fixtures :all
  integrate_views
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when authentication is invalid" do
    User.stub(:authenticate).and_return(nil)
    post :create
    response.should render_template(:new)
    session['user_id'].should be_nil
  end
  
  it "create action should redirect when authentication is valid" do
    User.stub(:authenticate).and_return(User.first)
    post :create
    response.should redirect_to(root_url)
    session['user_id'].should == User.first.id
  end

  it "destroys session successfully" do
    session[:user_id] = 100;

    get :destroy

    session[:user_id].should be_nil
    flash[:notice].should_not be_nil
    response.should redirect_to(root_url)
  end

end
