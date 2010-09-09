require 'spec_helper'

describe Utils do

  describe '.replace_all' do

    it 'should replace' do
      test_string = "a b c d e"
      replaced_string = Utils::replace_all(test_string, {'a' => '1', 'b' => '2', 'c' => '3', 'e' => '5'})
      replaced_string.should == "1 2 3 d 5"
    end

  end

  describe '.convert_russian_date' do

    it 'should convert russian dates' do
      dates_to_test = {
              '1 января 2010'   => Date.new(2010, 1, 1),
              '1 февраля 2010'  => Date.new(2010, 2, 1),
              '1 марта 2010'    => Date.new(2010, 3, 1),
              '1 апреля 2010'   => Date.new(2010, 4, 1),
              '1 мая 2010'      => Date.new(2010, 5, 1),
              '1 июня 2010'     => Date.new(2010, 6, 1),
              '1 июля 2010'     => Date.new(2010, 7, 1),
              '1 августа 2010'  => Date.new(2010, 8, 1),
              '1 сентября 2010' => Date.new(2010, 9, 1),
              '1 октября 2010'  => Date.new(2010, 10, 1),
              '1 ноября 2010'   => Date.new(2010, 11, 1),
              '1 декабря 2010'  => Date.new(2010, 12, 1)
      }

      for (date_str, right_date) in dates_to_test
        date_obj = Utils::convert_russian_date(date_str)
        date_obj.should == right_date
      end

    end

  end

end
