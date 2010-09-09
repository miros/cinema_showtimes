module Utils
  extend self

  def replace_all(string, hash)
    hash.inject(string) { |result, (search, replace_with)| result.gsub(search, replace_with) }
  end

  def convert_russian_date(date_str)

    conversion_table = {
      'января'   => 'january',
      'февраля'  => 'february',
      'марта'    => 'march',
      'апреля'   => 'april',
      'мая'      => 'may',
      'июня'     => 'june',
      'июля'     => 'july',
      'августа'  => 'august',
      'сентября' => 'september',
      'октября'  => 'october',
      'ноября'   => 'november',
      'декабря'  => 'december'    
    }

    Date.parse(Utils::replace_all(date_str, conversion_table))

  end

end