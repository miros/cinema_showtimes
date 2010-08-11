class Movie < ActiveRecord::Base

  has_many :shows

  named_scope :all_by_popularity, :joins => :shows, :group => 'movies.id, movies.name', :order => 'count(shows.id) desc'

  def search(params)

    found_shows = shows.by_date

    found_shows = found_shows.actual if params[:actual]
    found_shows = found_shows.in_interval(params) if (params[:from] or params[:to])
    found_shows = found_shows.for_date(date_param_to_date_object(params[:date]))

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

end
