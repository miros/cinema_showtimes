=begin
begin

class Time

  class << self
    alias_method :default_now, :now
  end

  def self.now
    self.default_now.utc.in_time_zone('Moscow')
  end

end


class DateTime

  class << self
    alias_method :default_now, :now
  end

  def self.now
    self.default_now.utc.in_time_zone('Moscow')
  end

end
end
=end
