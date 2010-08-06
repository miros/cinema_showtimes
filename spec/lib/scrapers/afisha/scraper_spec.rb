require "spec"

describe Scrapers::Afisha::Scraper do

  before(:each) do

    @browser = Browser.new
    @browser.stub!(:get).and_return('<html></html>')
    @parser = mock(Scrapers::Afisha::ShowsParser)
    @parser.stub!(:parse) .and_return([])

    @scraper = Scrapers::Afisha::Scraper.new(@browser, @parser)

  end

  it "should get showtimes for 3 days by default" do
    @browser.should_receive(:get).exactly(3).times
    @parser.should_receive(:parse).exactly(3).times.and_return([])

    @scraper.scrap
  end

  it "should return shows from all three parsed days" do
    @shows_array = [{}, {}, {}]
    @parser.should_receive(:parse).exactly(3).times.and_return(@shows_array)

    shows = @scraper.scrap
    shows.should have(@shows_array.length * 3).shows
  end

  it "should get showtimes at least for today" do
    today = DateTime.now.utc.in_time_zone('Moscow')

    @browser.should_receive(:get).with("http://www.afisha.ru/msk/schedule_cinema/#{today.strftime('%d-%m-%Y')}/")
    @parser.should_receive(:parse).with(anything(), anything()).and_return([])

    @scraper.scrap
  end

end