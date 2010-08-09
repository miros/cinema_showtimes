class ShowsCreator

  def create_shows(shows)
    shows.each do |show|
      cinema_hash = show[:cinema]
      cinema = Cinema.find_or_create_by_name(cinema_hash[:name], cinema_hash)

      movie_hash = show[:movie]
      movie = Movie.find_or_create_by_name(movie_hash[:name], movie_hash)

      show[:cinema] = cinema
      show[:movie] = movie

      Show.create(show)
    end
  end

end