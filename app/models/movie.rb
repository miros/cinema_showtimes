class Movie < ActiveRecord::Base

  has_many :shows

  named_scope :all_by_popularity, :joins => :shows, :group => 'movies.id, movies.name,
    movies.english_name, movies.genre, movies.country, movies.year, movies.duration, movies.afisha_link', :order => 'count(shows.id) desc'

  def search(params = {}, user = nil)

    found_shows = shows.ordered_by_date
    found_shows = found_shows.actual if params[:date].today?

    found_shows = found_shows.in_favourite_cinemas(user) if (params[:favourite_cinemas] && user)
    
    date_for_shows = params[:date]

    found_shows = found_shows.for_date(date_for_shows)

    if (params[:from] or params[:to])

      from = parse_time_param(params[:from]) || Time.now
      to = parse_time_param(params[:to]) || Time.now.end_of_day

      from = date_for_shows + from.hour.hours + from.min.minutes + from.sec.seconds
      to = date_for_shows + to.hour.hours + to.min.minutes + to.sec.seconds

      found_shows = found_shows.in_interval(from, to)
    end

    found_shows.with_cinemas
  end

  private

    def parse_time_param(param)
      return false if (!param || param.blank?)
      param = param + ':00' if !param.include?(':')
      Time.parse(param)
    end

end
