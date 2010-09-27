class Show < ActiveRecord::Base

  belongs_to :movie, :counter_cache => true
  belongs_to :cinema

  validates_presence_of :cinema_id, :movie_id, :time

  named_scope :ordered_by_date, :order => 'time ASC'
  named_scope :with_cinemas, :include => :cinema
  named_scope :with_movies, :include => :movie
  named_scope :actual, lambda { { :conditions => ['time > ?', Time.zone.now] } }
  named_scope :in_3d, :conditions => {:is_3d => 1}

  named_scope :in_interval, (lambda do |from, to|
    { :conditions => ['time BETWEEN ? and ?', from.utc, to.utc] }
  end)

  named_scope :for_date, (lambda do |date|
    { :conditions => ['time BETWEEN ? and ?', date.to_time.utc, (date + 1.day).to_time.utc] }
  end)

  named_scope :in_favourite_cinemas, (lambda do |user|
   { :joins => "join favourite_cinemas as fc ON fc.cinema_id = shows.cinema_id AND user_id = #{user.id}" }
  end)

  def time_formatted
    self.time.strftime('%H:%M')
  end

  def end_time_formatted
    (self.time + self.movie.duration.minutes).strftime('%H:%M') if self.movie.duration
  end


end
