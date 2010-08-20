class FavouriteCinema < ActiveRecord::Base

  belongs_to :user
  belongs_to :cinema

  named_scope :ordered_by_name, :joins => :cinema, :order => 'cinemas.name ASC'

end
