namespace :achievements do
  desc "Check for new user achievements"
  task :update => :environment do
    User.all.each do |user|
      user.update_from_external_sources
    end
  end
end