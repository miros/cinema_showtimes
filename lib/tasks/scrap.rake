Rake.application.options.trace = true

namespace :scrap do

  task :all => [:afisha]
  task :clean => ['db:reset', :all]

  task :afisha => :environment do

    browser = Browser.new
    scraper = Scrapers::Afisha::Scraper.new(browser, Scrapers::Afisha::ShowsParser.new)
    shows = scraper.scrap

    movie_scraper =  Scrapers::Afisha::MovieScraper.new(browser)
    ShowsCreator.new(movie_scraper).create_shows(shows)

  end

end