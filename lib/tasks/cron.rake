task :cron => ['scrap:clean', 'scrap:ratings']


task :update_3d_for_movies => [:environment] do

  Show.in_3d.all.map(&:movie).uniq.each do |movie|
    movie.update_attribute(:is_3d, true)
  end

end