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
  it "uploaded image must be shown in trainer" do
    visit "cards"
    click_link I18n.t("edit_short")
    attach_file I18n.t("example_image"), "#{Rails.root}/app/assets/images/1.png"
    click_button I18n.t("submit")
    visit user_path
    expect(page).to have_css("img[src*='1.png']")
  end
  it "uploaded image must be shown in all cards" do
    visit "cards"
    click_link I18n.t("edit_short")
    attach_file I18n.t("example_image"), "#{Rails.root}/app/assets/images/1.png"
    click_button I18n.t("submit")
    visit cards_path
    expect(page).to have_css("img[src*='1.png']")
  end
end