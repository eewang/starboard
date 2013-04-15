namespace :achievements do
  desc "Check for new user achievements"
  task :update => :environment do
    User.update_all
  end
end