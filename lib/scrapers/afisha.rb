require "rubygems"
require "nokogiri"
require "open-uri"

module Scrapers

  class Afisha

    AFISHA_URL = "http://www.afisha.ru"    

    def initialize(browser)
      @browser = browser
      @browser.referer = AFISHA_URL
    end

    def scrap
      @shows = []

      today_shows_page = parse_url '/msk/schedule_cinema/'

      today_shows_page.css('#schedule .object').each do |movie_block|
        parse_movie_block(movie_block)
      end

      @shows
    end

    private

      def parse_movie_block(movie_block)
        movie_name = movie_block.at_css('.usetags a').content
        movie = {:name => movie_name}

        movie_block.css('tr').each do |cinema_block|
          parse_cinema_block(movie, cinema_block)
        end
      end

      def parse_cinema_block(movie, cinema_block)
        return if cinema_block['id'] == nil

        cinema_name = cinema_block.at_css('.b-td-item a').content
        cinema = {:name => cinema_name, :city => 'москва'}

        show_times = create_show_times(cinema_block)
        create_shows(cinema, movie, show_times)
      end

      def create_show_times(cinema_block)
        show_times = parse_show_times(cinema_block)
        show_times += parse_show_times_for_3d_movies(cinema_block)
        return show_times
      end

      def create_shows(cinema, movie, show_times)
        show_times.each do |time|
          show = create_show(cinema, movie, time)
          @shows << show
        end
      end

      def parse_show_times_for_3d_movies(cinema_block)
        return [] if not next_block_is_for_3d_movies(cinema_block)
        parse_show_times(cinema_block.next)
      end

      def next_block_is_for_3d_movies(cinema_block)
        cinema_block['class'] == 's-tr-next3d'
      end

      def create_show(cinema, movie, time)
        show = {}

        show_time_min, show_time_sec = time.split(':')
        now = DateTime.now.utc.in_time_zone('Moscow')

        show[:time] = Time.utc(now.year, now.month, now.day, show_time_min, show_time_sec, 0)
        show[:movie] = movie
        show[:cinema] = cinema
        return show
      end

      def parse_show_times(cinema_block)
        cinema_block.css('.b-td-timetable .line span').map {|time_block| time_block.content.strip }
      end

      def parse_url(url)
        html = get_html(url)
        Nokogiri::HTML(html)
      end

      def get_html(url)
        url = AFISHA_URL + url
        puts "Url: #{url}"
        html = @browser.get(url)
        html
      end

  end


end

