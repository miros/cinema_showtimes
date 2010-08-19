require 'spec_helper'

describe FavouriteCinemasController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/favourite_cinemas" }.should route_to(:controller => "favourite_cinemas", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/favourite_cinemas/new" }.should route_to(:controller => "favourite_cinemas", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/favourite_cinemas/1" }.should route_to(:controller => "favourite_cinemas", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/favourite_cinemas/1/edit" }.should route_to(:controller => "favourite_cinemas", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/favourite_cinemas" }.should route_to(:controller => "favourite_cinemas", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/favourite_cinemas/1" }.should route_to(:controller => "favourite_cinemas", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/favourite_cinemas/1" }.should route_to(:controller => "favourite_cinemas", :action => "destroy", :id => "1") 
    end
  end
end
