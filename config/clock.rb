require 'clockwork'
require File.expand_path('../boot', __FILE__)
require File.expand_path('../environment', __FILE__)
include Clockwork

handler do |job|
  puts "Running #{job}"
end

every 5.minutes, 'update_users' do
  User.update_all
end