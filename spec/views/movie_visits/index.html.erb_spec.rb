require 'spec_helper'

describe "/movie_visits/index.html.erb" do
  include MovieVisitsHelper

  before(:each) do
    assigns[:movie_visits] = [
      stub_model(MovieVisit,
        :user_id => 1,
        :movie_id => 1,
        :cinema_id => 1
      ),
      stub_model(MovieVisit,
        :user_id => 1,
        :movie_id => 1,
        :cinema_id => 1
      )
    ]
  end

  it "renders a list of movie_visits" do
    render
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end
