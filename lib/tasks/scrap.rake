Rake.application.options.trace = true

namespace :scrap do

  task :all => [:afisha]

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

  task :kinopoisk_without_info => :environment do
    update_kinopoisk_info { Movie.without_info.all(:order => 'id desc') }
  end

  task :kinopoisk_new_films => :environment do
    update_kinopoisk_info { Movie.all(:limit => 200, :order => 'id desc') }
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


task :update_3d_for_movies => [:environment] do

  Show.in_3d.all.map(&:movie).uniq.each do |movie|
    movie.update_attribute(:is_3d, true)
  end

end

task :reset_shows => :environment do
  Show.delete_all
  Movie.update_all :shows_count => 0
end

task :reset_movies=> :environment do
  Movie.delete_all
end