require 'spec_helper'

describe "/movie_visits/new.html.erb" do
  include MovieVisitsHelper

  before(:each) do
    assigns[:movie_visit] = stub_model(MovieVisit,
      :new_record? => true,
      :user_id => 1,
      :movie_id => 1,
      :cinema_id => 1
    )
  end

  it "renders new movie_visit form" do
    render

    response.should have_tag("form[action=?][method=post]", movie_visits_path) do
      with_tag("input#movie_visit_user_id[name=?]", "movie_visit[user_id]")
      with_tag("input#movie_visit_movie_id[name=?]", "movie_visit[movie_id]")
      with_tag("input#movie_visit_cinema_id[name=?]", "movie_visit[cinema_id]")
    end
  end
end
