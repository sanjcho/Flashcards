require "rails_helper"
require "helpers"

describe "actions with cards", type: :feature do
  before :each do
    user_and_card_create
    login(@user)
  end

  it "created card must be shown in all_cards page" do
    visit "user"
    click_link I18n.t("add_c")
    fill_in I18n.t("original"), with: "cat"
    fill_in I18n.t("translated"), with: "кот"
    click_button I18n.t("submit")
    expect(page).to have_content "кот"
  end
  it "edited card must be shown in all_cards page" do
    visit "cards"
    click_link I18n.t("edit_short")
    fill_in I18n.t("original"), with: "house"
    fill_in I18n.t("translated"), with: "дом"
    click_button I18n.t("submit")
    expect(page).to have_content "дом"
  end
end
