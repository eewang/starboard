env :PATH, ENV["PATH"]
env "GEM_HOME", ENV["GEM_HOME"]

set :output, "./log/whenever.log"
set :job_template, "/bin/bash -i -c ':job'"

every 5.minutes do
  runner "User.update_all_users"
end
