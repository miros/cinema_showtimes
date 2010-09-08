class MovieVisit < ActiveRecord::Base

  default_scope :order => 'date DESC'

  belongs_to :user
  belongs_to :cinema
  belongs_to :movie

  validates_presence_of :user_id, :movie_id, :cinema_id

end
