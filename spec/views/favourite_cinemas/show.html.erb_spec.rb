require 'spec_helper'

describe "/favourite_cinemas/show.html.erb" do
  include FavouriteCinemasHelper
  before(:each) do
    assigns[:favourite_cinema] = @favourite_cinema = stub_model(FavouriteCinema)
  end

  it "renders attributes in <p>" do
    render
  end
end
