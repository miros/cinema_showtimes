class ShowsCreator

  def initialize(movie_scrapers)
    @movie_scrapers = movie_scrapers
  end

  def create_shows(shows)
    shows.each do |show|
      cinema_hash = show[:cinema]
      cinema = Cinema.find_or_create_by_name(cinema_hash[:name], cinema_hash)

      movie_hash = show[:movie]

      movie = Movie.find_by_name(movie_hash[:name])

      unless movie
        movie_hash = apply_movie_scrapers(movie_hash)
        movie = Movie.create(movie_hash)
      end

      show[:cinema] = cinema
      show[:movie] = movie

      Show.create(show)
    end
  end

  private

    def apply_movie_scrapers(movie_hash)
      @movie_scrapers.each {|scraper| movie_hash = scraper.scrap(movie_hash)}
      movie_hash
    end

end