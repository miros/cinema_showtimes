class Movie < ActiveRecord::Base

  has_many :shows

  named_scope :ordered_by_popularity, :joins => :shows, :group => 'movies.id, movies.name', :order => 'count(shows.id) desc'

end
