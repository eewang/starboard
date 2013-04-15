require 'clockwork'
require './config/boot'
require './config/environment'
include Clockwork

Clockwork.configure do |config|
  config[:sleep_timeout] = 5
  config[:logger] = Logger.new('./log/clockwork.log')
end

handler do |job|
  puts "Running #{job}"
end

every 5.minutes, 'update_users' do
  User.update_all
end
