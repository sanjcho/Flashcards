require "rails_helper"
require "helpers"

describe "card training process", type: :feature do 
  before :each do
    user = create(:user)
  	card = create(:card, user: user)
    card.review_date = Date.today.days_ago(4)
    card.save
  end

  it "card checking out" do
    visit "home"
    fill_in "compared_text", with: 'Mom'
    
    click_button "Проверить"
    expect(page).to have_content 'Верно!'

  end
end