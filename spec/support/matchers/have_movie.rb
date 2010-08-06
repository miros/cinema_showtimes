require 'pp'

module MovieSpecHelpers

  extend self

  def find_movie_show(shows, movie)
    shows.find_all do |show|
       show[:movie][:name] == movie[:movie_name] and
       show[:cinema][:name] == movie[:cinema_name]
     end
  end

  def find_show_at(shows, hour, minute)
    shows.find do |show|
      show[:time].hour == hour and
      show[:time].min == minute
    end
  end

end

Spec::Matchers.define :have_movie do |expected|

  match do |shows|

    matched_shows = MovieSpecHelpers::find_movie_show(shows, expected)

    if expected[:shows_count]
      matched_shows.length == expected[:shows_count]
    else
      !matched_shows.empty?
    end
  end

  failure_message_for_should do |shows|
    "expected that shows would have #{expected.inspect}"
  end

  failure_message_for_should_not do |shows|
    "expected that shows would not have #{expected.inspect}"
  end

  description do
    "have movie with info #{expected}"
  end

end