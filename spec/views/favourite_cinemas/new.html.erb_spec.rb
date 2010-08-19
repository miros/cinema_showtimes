require 'spec_helper'

describe "/favourite_cinemas/new.html.erb" do
  include FavouriteCinemasHelper

  before(:each) do
    assigns[:favourite_cinema] = stub_model(FavouriteCinema,
      :new_record? => true
    )
  end

  it "renders new favourite_cinema form" do
    render

    response.should have_tag("form[action=?][method=post]", favourite_cinemas_path) do
    end
  end
end
