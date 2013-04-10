require 'bundler/capistrano'
require 'sidekiq/capistrano'
require 'clockwork'

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
role :db,  "192.34.56.207", :primary => true # This is where Rails migrations will run
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
    run "ln -nfs #{shared_path}/user_pass.yml #{release_path}/config/user_pass.yml"
    run "ln -nfs #{shared_path}/sidekiq.yml #{release_path}/config/sidekiq.yml"
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

after "deploy:stop", "clockwork:stop"
after "deploy:start", "clockwork:start"
after "deploy:restart", "clockwork:restart"
 
set :clockwork_roles, :blabla
set :cw_log_file, "#{current_path}/log/clockwork.log"
set :cw_pid_file, "#{current_path}/tmp/pids/clockwork.pid"
set :rails_env, ENV['rails_env'] || ''
 
namespace :clockwork do
  desc "Stop clockwork"
  task :stop, :roles => :app, :on_no_matching_servers => :continue do
    #2>/dev/null skips errors if the file is found but process is not running for some reason
    run "if [ -d #{current_path} ] && [ -f #{cw_pid_file} ]; then cd #{current_path} && kill -int $(cat #{cw_pid_file}) 2>/dev/null; else echo 'clockwork was not running' ; fi"
  end
 
  desc "Start clockwork"
  task :start, :roles => :app, :on_no_matching_servers => :continue do
    run "cd #{current_path}; nohup bundle exec clockwork config/clock.rb -e #{rails_env} >> #{current_path}/log/clockwork.log 2>&1 &", :pty => false
    # get process id
    run "ps -eo pid,command | grep clockwork | grep -v grep | awk '{print $1}' > #{cw_pid_file}"
  end
 
  desc "Restart clockwork"
  task :restart, :roles => :clockwork_roles, :on_no_matching_servers => :continue do
    stop
    start
  end
end