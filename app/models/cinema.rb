class Cinema < ActiveRecord::Base

  has_many :shows, :order => 'time ASC'

end
