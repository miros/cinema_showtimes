set :application, "films"
set :repository,  "git@github.com:miros/cinema_showtimes.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "mirosm.ru" # Your HTTP server, Apache/etc
role :app, "mirosm.ru" # This may be the same as your `Web` server
role :db,  "mirosm.ru", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

set :deploy_to, "/var/www/#{application}"

set :user, "miros"
set :scm_username, "miros"

ssh_options[:compression] = false
default_run_options[:pty] = true

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :rake do
  desc "Run a task on a remote server."
  task :invoke do
    run("cd #{deploy_to}/current && /usr/bin/env rake #{ENV['TASK']} RAILS_ENV=production")  
  end
end