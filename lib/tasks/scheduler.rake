desc "Task for mark/unmark user's who have exired cards and send an eMail to them"
task :mailer_feed => :environment do
   User.have_expired_card_mail
 end
