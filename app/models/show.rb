class Show < ActiveRecord::Base

  belongs_to :movie
  belongs_to :cinema

end
