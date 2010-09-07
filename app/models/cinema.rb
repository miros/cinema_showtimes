class Cinema < ActiveRecord::Base

  has_many :shows, :order => 'time ASC'

  validates_presence_of :name

end
