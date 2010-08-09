class Movie < ActiveRecord::Base

  has_many :shows

  named_scope :all_by_popularity, :joins => :shows, :group => 'movies.id, movies.name', :order => 'count(shows.id) desc'

  def all_shows
    shows.by_date
  end

  def actual_shows
    all_shows.actual
  end

end
