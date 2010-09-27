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
        movie_link = movie_block.at_css('.usetags a')
        movie_name = movie_link.content

        movie = {:name => movie_name, :afisha_link => movie_link[:href]  }

        movie_block.css('tr').each do |cinema_block|
          parse_cinema_block(movie, cinema_block)
        end
      end

      def parse_cinema_block(movie, cinema_block)
        return if cinema_block['id'] == nil || cinema_block['id'] =~ /_id/

        cinema_name = cinema_block.at_css('.b-td-item a').content
        cinema = {:name => cinema_name, :city => 'москва'}

        parse_shows(cinema, movie, cinema_block)

      end

      def parse_shows(cinema, movie, cinema_block)
        create_shows(cinema, movie, parse_show_times(cinema_block))
        create_shows(cinema, movie, parse_show_times_for_3d_movies(cinema_block))
      end

      def create_shows(cinema, movie, show_times, is_3d = false)
        show_times.each do |time|
          show = create_show(cinema, movie, time, is_3d)
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

      def create_show(cinema, movie, time, is_3d = false)
        show = {}

        show_time_hour, show_time_min = time.split(':')

        show_date = @date
        show_date = show_date.tomorrow if (0..4) === show_time_hour.to_i
        
        show[:time] = Time.zone.local(show_date.year, show_date.month, show_date.day, show_time_hour, show_time_min, 0)
        show[:movie] = movie
        show[:cinema] = cinema
        show[:is_3d] = is_3d
        return show
      end

      def parse_show_times(cinema_block)
        cinema_block.css('.b-td-timetable .line span').map {|time_block| time_block.content.strip }
      end

  end

end