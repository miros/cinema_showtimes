require 'mechanize'

module Scrapers::Kinopoisk

  class MovieScraper

    KINOPOISK_URL = "http://www.kinopoisk.ru"

    def initialize(browser)
      @browser = browser
    end

    # !TODO REFACTOR

    def scrap(movie_hash)

      puts movie_hash.inspect

      @agent = WWW::Mechanize.new

      if APP_CONFIG['proxy']
        proxy_uri = URI::parse(APP_CONFIG['proxy'])
        @agent.set_proxy(proxy_uri.host, proxy_uri.port)
      end

      @agent.get(KINOPOISK_URL)

      search_form = @agent.page.form_with('searchForm')
      search_form.kp_query = movie_hash[:name]
      search_form.submit

      if @agent.page.uri.to_s =~ /index.php/
         movie_link = @agent.page.at('tr:nth-child(2) .all')
         return movie_hash unless movie_link
         @agent.get(movie_link[:href])
      end

      movie_image = @agent.page.at('.movie div a img')
      movie_hash[:image_url] =  KINOPOISK_URL + movie_image[:src] if movie_image

      imdb_rating_block = @agent.page.at('#block_rating div:nth-child(2)')
      movie_hash[:imdb_rating] = imdb_rating_block.text[/IMDB: ([0-9.]+)/, 1] if imdb_rating_block

      kinopoisk_rating_block = @agent.page.at('#block_rating a.continue')
      movie_hash[:kinopoisk_rating] = kinopoisk_rating_block.text[/[0-9.]+/] if kinopoisk_rating_block

      budget_td_block = find_tr('бюджет')
      if (budget_td_block && budget_td_block.text.starts_with?('$'))
        movie_hash[:budget] = budget_td_block.text.gsub(/[^\d]/, '').to_i
      end

      premier_td_block = find_tr('премьера (РФ)')
      movie_hash[:premier_date] = Utils::convert_russian_date(premier_td_block.at_css('a.all').text) if premier_td_block


      movie_hash
    end

    private

      def find_tr(caption)
        tr = @agent.page.search('table.info tr').find {|tr| tr.css('td').first.text.strip == caption }
        tr.css('td')[1] if tr
      end


  end

end