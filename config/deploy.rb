require 'bundler/capistrano'

set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"

set :application, "starboard"
set :repository,  "git@github.com:flatiron-school/starboard.git"

set :user, 'stargroup'
set :deploy_to, "/home/stargroup/starboard"
set :use_sudo, false

set :scm, :git

default_run_options[:pty] = true
# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "192.34.56.207"                          # Your HTTP server, Apache/etc
role :app, "192.34.56.207"                          # This may be the same as your `Web` server
# role :db,  "192.34.56.207", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :customs do
  task :symlink, :roles => :app do 
    run "ln -nfs #{shared_path}/system/uploads/octokit.rb #{release_path}/config/initializers/octokit.rb"
    run "ln -nfs #{shared_path}/database.yml #{release_path}/config/database.yml"
  end
end

before "deploy:assets:precompile","customs:symlink"
after "deploy","deploy:cleanup"

desc "tail production log files" 
task :tail_logs, :roles => :app do
  trap("INT") { puts 'Interupted'; exit 0; }
  run "tail -f #{shared_path}/log/production.log" do |channel, stream, data|
    puts  # for an extra line break before the host name
    puts "#{channel[:host]}: #{data}" 
    break if stream == :err
  end
end