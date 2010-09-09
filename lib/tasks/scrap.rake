Rake.application.options.trace = true

namespace :scrap do

  task :all => [:afisha]
  task :clean => [:reset_shows, :all]

  task :afisha => :environment do

    browser = Browser.new
    scraper = Scrapers::Afisha::Scraper.new(browser, Scrapers::Afisha::ShowsParser.new)
    shows = scraper.scrap

    afisha_movie_scraper =  Scrapers::Afisha::MovieScraper.new(browser)
    kinopoisk_movie_scraper =  Scrapers::Kinopoisk::MovieScraper.new(browser)
    movie_scrapers = [afisha_movie_scraper, kinopoisk_movie_scraper]

    ShowsCreator.new(movie_scrapers).create_shows(shows)

  end

  task :kinopoisk => :environment do
    update_kinopoisk_info { Movie.all }  
  end

  task :ratings => :environment do
    update_kinopoisk_info { Movie.with_outdated_ratings }
  end

  task :all_ratings => :environment do
    update_kinopoisk_info { Movie.find_all_by_kinopoisk_rating(nil) }
  end

  def update_kinopoisk_info()
    movie_scraper =  Scrapers::Kinopoisk::MovieScraper.new(Browser.new)

    movies = yield

    movies.each do |movie|
      info = movie_scraper.scrap({:name => movie.name})
      puts info.inspect
      movie.update_attributes(info)
    end
  end

end




task :reset_shows => :environment do
  Show.delete_all
end

task :reset_movies=> :environment do
  Movie.delete_all
end