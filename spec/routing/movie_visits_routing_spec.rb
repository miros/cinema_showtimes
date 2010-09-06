require 'spec_helper'

describe MovieVisitsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/movie_visits" }.should route_to(:controller => "movie_visits", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/movie_visits/new" }.should route_to(:controller => "movie_visits", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/movie_visits/1" }.should route_to(:controller => "movie_visits", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/movie_visits/1/edit" }.should route_to(:controller => "movie_visits", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/movie_visits" }.should route_to(:controller => "movie_visits", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/movie_visits/1" }.should route_to(:controller => "movie_visits", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/movie_visits/1" }.should route_to(:controller => "movie_visits", :action => "destroy", :id => "1") 
    end
  end
end
