class Show < ActiveRecord::Base

  belongs_to :movie
  belongs_to :cinema

  named_scope :by_date, :order => 'time ASC'
  named_scope :with_cinemas, :include => :cinema
  named_scope :actual, lambda { { :conditions => ['time > ?', Time.now] } }

  def time_formatted
    self.time.strftime('%H:%M (%d-%m-%Y)')
  end

end
