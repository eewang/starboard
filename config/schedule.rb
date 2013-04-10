env :PATH, "/home/stargroup/.rvm/rubies/ruby-1.9.3-p327/bin"

set :output, "./log/whenever.log"
set :job_template, "/bin/bash -i -c ':job'"

every 5.minutes do
  runner "User.update_all_users"
end
