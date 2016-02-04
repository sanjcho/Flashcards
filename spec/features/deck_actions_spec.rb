require "rails_helper"
require "helpers"

describe "actions with decks", type: :feature do
  before :each do
    user_deck_and_card_create
    login(@user)
  end
  
  it "deck must be shown in all decks page" do
    visit decks_path
    expect(page).to have_content "test"
  end

  it "created deck must appear in all decks page" do
    visit new_deck_path
    fill_in I18n.t("deck_name"), with: "somename"
    click_button I18n.t("submit")
    expect(page).to have_content "somename"
  end

  it "deleted deck must not be shown in all decks page" do
    visit decks_path
    click_link I18n.t("delete")
    expect(page).not_to have_content "test"
  end

  it "actovated deck must becae activated" do
    visit decks_path 
    click_link I18n.t("activate_curernt")
    expect(page).to have_content I18n.t("active_current")
  end

  it "changed card must be shown on all decks page with new name" do
    visit decks_path
    click_link I18n.t("edit_short")
    fill_in I18n.t("deck_name"), with: "testnew"
    click_button I18n.t("submit")
    expect(page).to have_content "testnew"
   end

end