module Helpers
  def user_new(mail, pass)
    build(:user, email: mail, password: pass, password_confirmation: pass)
  end

  def card_new(orig, transl) # new card without .save
    build(:card, user: User.first, original_text: orig, translated_text: transl, review_date: DateTime.now)
  end
end