namespace :achievements do
  desc "Check for new user achievements"
  task :update => :environment do
    User.find_each do |user|
      user.get_external_data
      user.save
    end
  end
end