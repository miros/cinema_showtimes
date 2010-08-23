module Scrapers::Afisha

  class Scraper

    AFISHA_URL = "http://www.afisha.ru"

    def initialize(browser, parser)
      @browser = browser
      @browser.referer = AFISHA_URL
      @parser = parser
      @shows = []
    end

    def scrap
      @shows = []

      today = DateTime.now.utc.in_time_zone('Moscow')

      dates_to_parse = [
        today,
        today.tomorrow,
        today.tomorrow.tomorrow
      ]

      dates_to_parse.each {|date| scrap_for_date(date)}
      
      @shows
    end

    private

      def scrap_for_date(date)
        url = AFISHA_URL + "/msk/schedule_cinema/#{date.strftime('%d-%m-%Y')}/"
        html = @browser.get(url)
        new_shows = @parser.parse(html, date)
        @shows += new_shows
      end

  end

end

