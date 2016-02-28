desc "Task for mail users who have exired cards"
task :mailer_feed => :environment do
   User.have_expired_card_mail
end
