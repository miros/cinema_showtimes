require File.dirname(__FILE__) + '/../spec_helper'
 
describe UsersController do

  integrate_views
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    stub_invalid_user
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    stub_valid_user
    post :create
    response.should redirect_to(root_url)
    session['user_id'].should == assigns['user'].id
  end


  def stub_valid_user()
    stub_new true
  end

  def stub_invalid_user()
    stub_new false
  end

  def stub_new(is_user_valid)
     User.stub(:new).and_return(@user = mock_model(User, :valid? => is_user_valid, :save => is_user_valid, :null_object => true))
  end

end
