class MovieVisit < ActiveRecord::Base

  belongs_to :user
  belongs_to :cinema
  belongs_to :movie

end
