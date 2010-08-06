require 'spec_helper'

describe Scrapers::Afisha::ShowsParser do

  include MovieSpecHelpers

  before(:all) do
    afisha_html = File.read(File.dirname(__FILE__) + '/schedule_cinema.html')
    today = DateTime.now.utc.in_time_zone('Moscow')
    @all_shows = Scrapers::Afisha::ShowsParser.new.parse(afisha_html, today)
  end

  it "should parse 2d movie correctly" do
    @all_shows.should have_movie(:movie_name => 'Солт', :cinema_name => 'Высота', :shows_count => 4 )
  end

  it "should parse movie showtime correctly" do
    salt_shows = find_movie_show(@all_shows, :movie_name => 'Солт', :cinema_name => 'Высота')
    find_show_at(salt_shows, 22, 30).should_not be_nil
  end

  it "should parse 3d movie correctly" do
    @all_shows.should have_movie(:movie_name => 'Кошки против собак: Месть Китти Галор',
                                 :cinema_name => 'Каро Фильм Атриум',
                                 :shows_count => 15)
  end

  it "should correctly handle times after midnight" do

    shows = find_movie_show(@all_shows,
                            :movie_name => 'Начало',
                            :cinema_name => 'Бумеранг на Варшавской')
    show = find_show_at(shows, 1, 15)

    tomorrow = DateTime.now.utc.in_time_zone('Moscow').tomorrow

    show[:time].day.should == tomorrow.day
    show[:time].month.should == tomorrow.month
  end

end
