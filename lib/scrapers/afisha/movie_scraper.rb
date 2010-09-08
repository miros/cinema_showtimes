module Scrapers::Afisha

  class MovieScraper


    def initialize(browser)
      @browser = browser
    end

    def scrap(movie_hash)

      html = @browser.get(movie_hash[:afisha_link])
      movie_page = Nokogiri::HTML(html)

      begin

        movie_hash[:english_name] = movie_page.at_css('p.orig-name').content.strip
        movie_hash[:genre] = movie_page.at_css('span.b-tags').content.split(',').map {|genre| genre.strip}.join(', ')

      rescue

      end

      match_data = movie_page.at_css('div.m-margin-btm').inner_html.match /(.+?), (\d+), (\d+) мин\./

      if match_data
        movie_hash[:country] = match_data[1].strip if match_data[1]
        movie_hash[:year] = match_data[2].to_i if match_data[2]
        movie_hash[:duration] = match_data[3].to_i if match_data[3]
      end

      movie_hash

    end



    private



  end

end