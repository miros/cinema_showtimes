Rake.application.options.trace = true

task :scrap => :scrap_afisha do

end

task :scrap_afisha => :environment do

  scraper = Scrapers::Afisha.new
  scraper.scrap

end