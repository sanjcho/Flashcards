require "rails_helper"
require "helpers"

describe "card training process", type: :feature do 
  before :each do
    user_deck_and_card_create
    login(@user)
  end

  it "card checking out, inactive deck" do
    visit "home"
    fill_in "compared_text", with: 'mom'
    click_button I18n.t("check")
    expect(page).to have_content I18n.t("success")
  end
  it "card checking out, active deck" do
    @deck.activate_it!
    deck = create(:deck, name: "test2", user: @user)
    create(:card, original_text:"bunny", translated_text: "заяц", deck: deck, user: @user)
    visit "home"
    fill_in "compared_text", with: 'mom'
    click_button I18n.t("check")
    expect(page).to have_content I18n.t("success")
  end
end