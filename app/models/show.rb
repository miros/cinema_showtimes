class Show < ActiveRecord::Base

  belongs_to :movie
  belongs_to :cinema

  named_scope :by_date, :order => 'time ASC'
  named_scope :with_cinemas, :include => :cinema
  named_scope :actual, lambda { { :conditions => ['time > ?', Time.now] } }


  # @TODO move default args to controller
  named_scope :in_interval, (lambda do |from, to|
    { :conditions => ['time BETWEEN ? and ?', from, to] }
  end)

  named_scope :for_date, (lambda do |date|
    { :conditions => ['time BETWEEN ? and ?', date, date + 1.day] }
  end)

  def time_formatted
    self.time.strftime('%H:%M (%d-%m-%Y)')
  end


end
