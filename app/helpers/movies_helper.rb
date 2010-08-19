module MoviesHelper

  def link_to_shows_starting_at(title, movie, time_interval)
    link_to title, movie_shows_actual_path(movie, :from => (Time.now + time_interval).strftime('%H:%M'), :to => '')
  end

end
