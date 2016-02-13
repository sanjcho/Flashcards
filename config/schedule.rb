# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 1.day, at: '18:45' do
 every 5.minutes do
   runner "User.expired_cards_mark"
   runner "User.have_expired_card_mail"
   runner "User.expired_cards_unmark"
 end

# Learn more: http://github.com/javan/whenever
