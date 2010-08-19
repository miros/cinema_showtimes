require 'spec_helper'

describe "/favourite_cinemas/index.html.erb" do
  include FavouriteCinemasHelper

  before(:each) do
    assigns[:favourite_cinemas] = [
      stub_model(FavouriteCinema),
      stub_model(FavouriteCinema)
    ]
  end

  it "renders a list of favourite_cinemas" do
    render
  end
end
