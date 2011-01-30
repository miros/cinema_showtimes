task :cron do
  Rake::Task["reset_shows"].invoke
  Rake::Task["scrap:all"].invoke
end

