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
end