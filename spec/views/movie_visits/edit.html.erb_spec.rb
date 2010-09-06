require 'spec_helper'

describe "/movie_visits/edit.html.erb" do
  include MovieVisitsHelper

  before(:each) do
    assigns[:movie_visit] = @movie_visit = stub_model(MovieVisit,
      :new_record? => false,
      :user_id => 1,
      :movie_id => 1,
      :cinema_id => 1
    )
  end

  it "renders the edit movie_visit form" do
    render

    response.should have_tag("form[action=#{movie_visit_path(@movie_visit)}][method=post]") do
      with_tag('input#movie_visit_user_id[name=?]', "movie_visit[user_id]")
      with_tag('input#movie_visit_movie_id[name=?]', "movie_visit[movie_id]")
      with_tag('input#movie_visit_cinema_id[name=?]', "movie_visit[cinema_id]")
    end
  end
end
