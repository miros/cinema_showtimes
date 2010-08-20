class Show < ActiveRecord::Base

  #def self.skip_time_zone_conversion_for_attributes
  # [:time]
  #end

  belongs_to :movie
  belongs_to :cinema

  named_scope :ordered_by_date, :order => 'time ASC'
  named_scope :with_cinemas, :include => :cinema
  named_scope :actual, lambda { { :conditions => ['time > ?', Time.zone.now] } }


  named_scope :in_interval, (lambda do |from, to|
    { :conditions => ['time BETWEEN ? and ?', from, to] }
  end)

  named_scope :for_date, (lambda do |date|
    { :conditions => ['time BETWEEN ? and ?', date, date + 1.day] }
  end)

  named_scope :in_favourite_cinemas, (lambda do |user|
   { :joins => "join favourite_cinemas as fc ON fc.cinema_id = shows.cinema_id AND user_id = #{user.id}" }
  end)

  def time_formatted
    self.time.strftime('%H:%M')
  end



end
