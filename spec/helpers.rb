module Helpers
  
  def user_new(mail, pass)
    User.new(email: mail, password: pass)
  end

  def card_new(orig, transl) # new card without .save
    User.first.cards.new(original_text: orig, translated_text: transl, review_date: DateTime.now)
  end
end