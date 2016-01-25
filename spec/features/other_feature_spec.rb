require "rails_helper"
require "helpers"

describe "login_logoute process and links vision", type: :feature do 
  before :each do
  user_and_card_create
  end

  it "unloggined_user must have sign_up link" do
    visit "home"
    expect(page).to have_content I18n.t("sign_up_link")
  end
  it "unloggined_user must have sign_in link" do
    visit "home"
    expect(page).to have_content I18n.t("login_link")
  end
  it "unlogined_user must not have my_page link" do
  	visit "home"
    expect(page).not_to have_content I18n.t("my_page")
  end
  it "logined user must have my_page link" do
    login(@user)
    visit "home"
    expect(page).to have_content I18n.t("my_page")
  end
  it "logined user must have clickable link edit_my_page" do
    login(@user)
    visit "home"
    click_link I18n.t("edit_user_link")
    expect(page).to have_content I18n.t("email_here")
  end
  it "logined user must have clickeble link to my_profile" do
    login(@user)
    visit "home"
    click_link I18n.t("my_page")
    expect(page).to have_content @user.email
  end


end