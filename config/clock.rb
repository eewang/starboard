require 'clockwork'
include Clockwork

handler do |job|
  puts "Running #{job}"
end

every 5.minutes, 'update_users' do
  User.update_all
end