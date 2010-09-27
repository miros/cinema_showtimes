class ShowsCreator

  def initialize(movie_scrapers)
    @movie_scrapers = movie_scrapers
  end

  def create_shows(shows)
    @shows = shows

    @shows.each do |show|
      cinema_hash = show[:cinema]
      cinema = Cinema.find_or_create_by_name(cinema_hash[:name], cinema_hash)

      movie_hash = show[:movie]

      movie = Movie.find_by_name(movie_hash[:name])
      movie = create_movie(movie_hash) unless movie

      show[:cinema] = cinema
      show[:movie] = movie

      Show.create(show)
    end
  end

    private

      def create_movie(movie_hash)
        movie_hash = apply_movie_scrapers(movie_hash)
        movie_hash[:is_3d] = is_movie_in_3d(movie_hash)
        Movie.create(movie_hash)
      end

      def is_movie_in_3d(movie_hash)
        @shows.select {|show| show[:movie][:name] == movie_hash[:name]}.any? {|show| show[:is_3d]}
      end

      def apply_movie_scrapers(movie_hash)
        @movie_scrapers.each {|scraper| movie_hash = scraper.scrap(movie_hash)}
        movie_hash
      end

end