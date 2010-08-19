require 'spec_helper'

describe "/favourite_cinemas/edit.html.erb" do
  include FavouriteCinemasHelper

  before(:each) do
    assigns[:favourite_cinema] = @favourite_cinema = stub_model(FavouriteCinema,
      :new_record? => false
    )
  end

  it "renders the edit favourite_cinema form" do
    render

    response.should have_tag("form[action=#{favourite_cinema_path(@favourite_cinema)}][method=post]") do
    end
  end
end
