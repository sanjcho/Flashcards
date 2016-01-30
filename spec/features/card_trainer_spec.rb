require "rails_helper"
require "helpers"

describe "card training process", type: :feature do 
  before :each do
    user_and_card_create
    login(@user)
  end

  it "card checking out" do
    visit user_path
    fill_in "compared_text", with: 'Mom'
    click_button I18n.t("check")
    expect(page).to have_content I18n.t("success")

  end
end