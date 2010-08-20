require 'spec_helper'

describe FavouriteCinemasController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/favourite_cinemas" }.should route_to(:controller => "favourite_cinemas", :action => "index")
    end

    it "recognizes and generates #create" do
      { :post => "/favourite_cinemas" }.should route_to(:controller => "favourite_cinemas", :action => "create") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/favourite_cinemas/1" }.should route_to(:controller => "favourite_cinemas", :action => "destroy", :id => "1") 
    end

  end
end
