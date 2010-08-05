require 'spec_helper'

describe Scrapers::Afisha do


  before(:all) do

    browser = Browser.new

    afisha_html = File.read(File.dirname(__FILE__) + '/schedule_cinema.html')

    browser.should_receive(:get).
            with('http://www.afisha.ru/msk/schedule_cinema/').
            and_return(afisha_html)

    @scraper = Scrapers::Afisha.new(browser)
    @all_shows = @scraper.scrap

  end


  it "should scrap 'Salt' movie" do

    salt_shows = @all_shows.find_all {|show| show[:movie][:name] == 'Солт' and show[:cinema][:name] == 'Высота' }
    salt_shows.should have(4).shows

    salt_shows.find { |show| show[:time].hour == 14 and show[:time].min == 50 }.
            should_not be_nil

  end

  it "should scrap 3d movie 'Cats vs Dogs'" do
    shows = @all_shows.find_all {|show| show[:movie][:name] == 'Кошки против собак: Месть Китти Галор' and show[:cinema][:name] == 'Каро Фильм Атриум' }
    shows.should have(15).shows
  end

end