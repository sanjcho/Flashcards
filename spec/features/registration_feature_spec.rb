require "rails_helper"
require "helpers"
  
  describe "registration process", type: :feature do 
    it "user email must be shown in my_page after registration" do
      visit "home"
      click_link I18n.t("sign_up_link")
      fill_in I18n.t("email_here"), with: "mymail@gmail.com"
      fill_in I18n.t("password_here"), with: "mypassword"
      fill_in I18n.t("password_confirmation_here"), with: "mypassword"
      click_button I18n.t("submit")
      click_link I18n.t("my_page")
      expect(page).to have_content "mymail@gmail.com"
    end
  end