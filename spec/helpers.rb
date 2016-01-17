module Helpers
  def card_new (orig, transl) #new card without .save
    Card.new(original_text: orig, translated_text: transl, review_date: DateTime.now)
  end
end