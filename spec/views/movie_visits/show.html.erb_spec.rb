require 'spec_helper'

describe "/movie_visits/show.html.erb" do
  include MovieVisitsHelper
  before(:each) do
    assigns[:movie_visit] = @movie_visit = stub_model(MovieVisit,
      :user_id => 1,
      :movie_id => 1,
      :cinema_id => 1
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/1/)
    response.should have_text(/1/)
    response.should have_text(/1/)
  end
end
