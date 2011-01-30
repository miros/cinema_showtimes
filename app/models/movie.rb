class Movie < ActiveRecord::Base

  has_many :shows

  validates_presence_of :name

  named_scope :all_by_popularity, :order => 'shows_count DESC'
  named_scope :all_by_name, :order => 'name ASC'

  named_scope :all_by_screens, :order => %{
    (SELECT DISTINCT COUNT(*) FROM shows WHERE shows.movie_id = movies.id) DESC
  }

  named_scope :in_3d, :conditions => {:is_3d => 1}
  named_scope :without_info, :conditions => {:about => nil}

  named_scope :actual, lambda {||
    {:conditions => "(select id FROM shows AS actual_shows WHERE
        actual_shows.movie_id = movies.id AND
        actual_shows.time BETWEEN
          '#{Time.zone.now.to_s(:db)}' AND '#{(Date.today.end_of_day + 5.hours).to_s(:db)}' 
      LIMIT 1) IS NOT NULL"}
  }

  named_scope :unseen, lambda {|user|
    {:joins => "LEFT JOIN movie_visits AS visit ON visit.movie_id = movies.id AND user_id = #{user.id}", :conditions => 'visit.id IS NULL'}
  }

  named_scope :with_outdated_ratings, lambda {||
    {:conditions => ['updated_at < ? AND created_at > ?', 5.days.ago, 30.days.ago]}
  }

  named_scope :premieres, lambda {||
    {:conditions => ['premier_date > ?', Time.zone.now.beginning_of_week.to_date]}
  }

  def premiere?()
    return false unless premier_date
    return self.premier_date > Time.zone.now.beginning_of_week.to_date
  end

  def search(params = {}, user = nil)

    found_shows = shows.ordered_by_date
    found_shows = found_shows.actual if params[:date].today?

    found_shows = found_shows.in_favourite_cinemas(user) if (params[:favourite_cinemas] && user)
    found_shows = found_shows.in_3d if params[:in_3d] 

    date_for_shows = params[:date]

    found_shows = found_shows.for_date(date_for_shows)

    if (params[:from] or params[:to])

      from = parse_time_param(params[:from]) || Time.zone.now
      to = parse_time_param(params[:to]) || Time.zone.now.end_of_day

      from = date_for_shows + from.hour.hours + from.min.minutes + from.sec.seconds
      to = date_for_shows + to.hour.hours + to.min.minutes + to.sec.seconds

      found_shows = found_shows.in_interval(from, to)
    end

    found_shows.with_cinemas.with_movies
  end

  private

    def parse_time_param(param)
      return false if (!param || param.blank?)
      param = param + ':00' if !param.include?(':')
      Time.zone.parse(param)
    end

end
