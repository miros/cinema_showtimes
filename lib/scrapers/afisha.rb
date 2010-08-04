require "rubygems"
require "nokogiri"
require "open-uri"

module Scrapers

  class Afisha

    AFISHA_URL = "http://www.afisha.ru"    

    def scrap
      today_shows_page = parse_url '/msk/schedule_cinema/'
      today_shows_page.css('#schedule .object').each do |movie_block|
        parse_movie_block(movie_block)
      end

    end

    private

      def parse_movie_block(movie_block)
        movie_name = movie_block.at_css('.usetags a').content

        movie = Movie.find_or_create_by_name(movie_name)

        movie_block.css('tr').each do |cinema_block|
          next if cinema_block['id'] == nil

          cinema_name = cinema_block.at_css('.b-td-item a').content
          cinema = Cinema.find_or_create_by_name_and_city(:name => cinema_name, :city => 'москва')

          show_times = parse_show_times(cinema_block)

          if cinema_block['class'] == 's-tr-next3d'
            show_times += parse_show_times(cinema_block.next)
          end

          show_times.each do |time|
            show = Show.new

            show_time_min, show_time_sec = time.split(':')
            show.time = Time.local(Time.now.year, Time.now.month, Time.now.day, show_time_min, show_time_sec, 0)
           
            show.movie = movie
            show.cinema = cinema
            show.save!
          end

         end

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
        proxy = nil #"http://192.168.1.250:3128"
        html = open(url, :proxy => proxy,
          "Referer" => "http://www.afisha.ru",
          "User-Agent" => "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.19) Gecko/2010040116 Ubuntu/9.04 (jaunty) Firefox/3.0.19 FirePHP/0.4",
          "Accept-Charset" => "UTF-8,*"
        ).read
        html
      end


  end


end

