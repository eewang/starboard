namespace :achievements do
  desc "Check for new user achievements"
  task :update => :environment do
    u = User.first
    u.get_external_data
    u.save
    # User.all.each do |user|
    #   user.get_external_data
    #   user.save
    end
  end
# end