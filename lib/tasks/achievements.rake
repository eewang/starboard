namespace :achievements do
  desc "Check for new user achievements"
  task :update => :environment do
    User.all.each do |user|
      user.save
    end
  end
end