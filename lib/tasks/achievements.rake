namespace :achievements do
  desc "Check for new user achievements"
  task :update => :environment do
    User.find_each do |user|
      user.update_from_external_sources
      user.save
    end
  end
end