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

  task :images => :environment do
    movie_scraper =  Scrapers::Kinopoisk::MovieScraper.new(Browser.new)

    Movie.find_all_by_image_url(nil).each do |movie|
      info = movie_scraper.scrap({:name => movie.name})
      puts info[:image_url]
      movie.update_attribute(:image_url, info[:image_url]) if info[:image_url] 
    end

  end

end


task :reset_shows => :environment do
  Show.delete_all
end

task :reset_movies=> :environment do
  Movie.delete_all
end