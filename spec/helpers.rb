module Helpers
  
  def user_new(mail, pass)
    user = build(:user, email: mail, password: pass)
  end

  def card_new(orig, transl) # new card without .save
    card = build(:card, user: User.first, original_text: orig, translated_text: transl, review_date: DateTime.now)
  end
end