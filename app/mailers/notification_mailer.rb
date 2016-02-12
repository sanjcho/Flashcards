class NotificationMailer < ApplicationMailer
  default from: 'notifications@flashcards-sanjcho.heroku.com'

  def expired_cards_email(user)
    @user = user
    @deck = user.decks.current
    mail(to: @user.email, subject: t("some_expired_flashcards_exists"))
  end
end
