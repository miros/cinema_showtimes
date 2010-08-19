# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def add_cinema_to_favourites_link(cinema)
    if current_user && !current_user.has_cinema_in_favourites(cinema)
        '[' + link_to("+" , {:controller => :favourite_cinemas, :action => :create, :cinema_id => cinema.id}, :method => :post) + ']'
    end
  end


end
