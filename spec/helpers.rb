module Helpers
  def user_new(mail, pass)
    build(:user, email: mail, password: pass, password_confirmation: pass)
  end

  def deck_new(name)
    build(:deck, user: User.first, name: name)
  end

  def card_new(orig, transl) # new card without .save
    build(:card, user: User.first, deck: Deck.first, original_text: orig, translated_text: transl, review_date: DateTime.now)
  end

  def login(user)
    visit new_session_path
    fill_in I18n.t('email_here'), with: user.email
    fill_in I18n.t('password_here'), with: "password"
    click_button I18n.t('submit')
  end

  def logout
    visit "home"
    click_link I18n.t('logout_link')
  end

  def user_deck_and_card_create
  	@user = create(:user)
    @deck = create(:deck, user: @user)
    card = build(:card, deck: @deck)
    card.user_id = @user.id
    #card.review_date = Date.today.days_ago(4)
    @card = card.save
    Card.last.update_columns(review_date: Date.today.days_ago(4))
    puts Card.last.deck_id  
  end
end