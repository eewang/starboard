job_type :rake, "{ cd #{@current_path} > /dev/null; } && RAILS_ENV=:environment bundle exec rake :task --silent :output"
job_type :script, "{ cd #{@current_path} > /dev/null; } && RAILS_ENV=:environment bundle exec script/:task :output"
job_type :runner, "{ cd #{@current_path} > /dev/null; } && RAILS_ENV=:environment bundle exec rails runner ':task' :output"

set :output, "./log/whenever.log"
set :job_template, "/bin/bash -i -c ':job'"

every 5.minutes do
  runner "User.update_all_users"
end
