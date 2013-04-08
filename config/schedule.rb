set :job_template, "/bin/bash -i -c ':job'"

every 5.minutes do
  runner "User.update_all_users"
end