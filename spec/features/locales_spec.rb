require "rails_helper"
require "helpers"

describe "actions with cards", type: :feature do
  before :each do
    user_deck_and_card_create
  end

  it "not logined user have locale from the browser header" do
    visit "http://localhost:3000/home"
    expect(page).to have_content(I18n.t("login_link"))
    expect(I18n.locale).to be(:en) #default capybara locale in header is eng
  end

  it "not logined user can choose a locale" do
    visit "home"
    click_link "Рус"
    expect(I18n.locale).to be(:ru)
  end
  it "logined user can choose a locale in the settings" do
  	login(@user)
  	visit edit_user_path
  	choose("English")
  	click_button I18n.t("submit")
  	expect(I18n.locale).to be(:en)
  end
end