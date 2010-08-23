require 'spec_helper'

describe Scrapers::Afisha::ShowsParser do

  before(:each) do
    @html = File.read(File.dirname(__FILE__) + '/expendables_movie.html')

    @browser = Browser.new
    @browser.stub!(:get).and_return(@html)

    @scraper = Scrapers::Afisha::MovieScraper.new(@browser)
  end


  it 'should scrap correct url' do
    movie_hash = {}
    movie_hash[:afisha_link] = 'fake url'

    @browser.should_receive(:get).with(movie_hash[:afisha_link]).and_return(@html)
    @scraper.scrap(movie_hash)

  end

  describe 'scraping expendables movie' do

    before(:all) do
      @html = File.read(File.dirname(__FILE__) + '/expendables_movie.html')

      @browser = Browser.new
      @browser.stub!(:get).and_return(@html)

      @scraper = Scrapers::Afisha::MovieScraper.new(@browser)

      @movie_hash = {}
      @movie_hash = @scraper.scrap(@movie_hash)
    end

    it 'should scrap english title' do
      @movie_hash[:english_name].should == 'The Expendables'
    end

    it 'should scrap genres' do
      @movie_hash[:genre].should == 'Боевики, приключенческие фильмы, триллеры'
    end

    it 'should scrap country' do
      @movie_hash[:country].should == 'США'
    end

    it 'should scrap year' do
      @movie_hash[:year].should == 2010
    end

    it 'should scrap duration' do
      @movie_hash[:duration].should == 90
    end

  end


end
