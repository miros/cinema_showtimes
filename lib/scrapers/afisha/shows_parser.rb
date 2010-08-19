require "rubygems"
require "nokogiri"
require "open-uri"

module Scrapers::Afisha

  # @TODO add logging

  class ShowsParser

    def parse(html, date)

      @date = date
      @shows = []

      today_shows_page = Nokogiri::HTML(html)

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

        show_time_hour, show_time_min = time.split(':')

        show_date = @date
        show_date = show_date.tomorrow if (0..4) === show_time_hour.to_i
        
        show[:time] = Time.zone.local(show_date.year, show_date.month, show_date.day, show_time_hour, show_time_min, 0)
        show[:movie] = movie
        show[:cinema] = cinema
        return show
      end

      def parse_show_times(cinema_block)
        cinema_block.css('.b-td-timetable .line span').map {|time_block| time_block.content.strip }
      end

  end

end