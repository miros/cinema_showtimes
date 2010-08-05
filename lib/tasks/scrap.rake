Rake.application.options.trace = true

namespace :scrap do

  task :all => [:afisha]
  task :clean => ['db:reset', :all]

  task :afisha => :environment do
    browser = Browser.new
    scraper = Scrapers::Afisha.new(browser)
    shows = scraper.scrap
    ShowsCreator.new.create_shows(shows)
  end

end