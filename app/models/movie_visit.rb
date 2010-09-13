class MovieVisit < ActiveRecord::Base

  default_scope :joins => :movie, :order => 'date DESC, movies.name ASC'

  belongs_to :user
  belongs_to :cinema
  belongs_to :movie

  validates_presence_of :user_id, :movie_id

end
