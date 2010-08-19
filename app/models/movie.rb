class Movie < ActiveRecord::Base

  has_many :shows

  named_scope :all_by_popularity, :joins => :shows, :group => 'movies.id, movies.name', :order => 'count(shows.id) desc'

  def search(params, user = nil)

    found_shows = shows.by_date
    found_shows = found_shows.actual if params[:actual]

    found_shows = found_shows.in_favourite_cinemas(user) if (params[:favourite_cinemas] && user)

    date_for_shows = date_param_to_date_object(params[:date])

    found_shows = found_shows.for_date(date_for_shows)

    if (params[:from] or params[:to])

      from = parse_time_param(params[:from]) || Time.now
      to = parse_time_param(params[:to]) || Time.now.end_of_day

      from = date_for_shows + from.hour.hours + from.min.minutes + from.sec.seconds
      to = date_for_shows + to.hour.hours + to.min.minutes + to.sec.seconds

      found_shows = found_shows.in_interval(from, to)
    end

    found_shows
  end

  private

    def date_param_to_date_object(date_param)
      case date_param
        when nil, 'today'
          Date.today
        when 'tomorrow'
          Date.tomorrow
        else
          Date.parse(date_param)
      end
    end

    def parse_time_param(param)
      return false if (!param || param.blank?)
      param = param + ':00' if !param.include?(':')
      Time.parse(param)
    end

end
