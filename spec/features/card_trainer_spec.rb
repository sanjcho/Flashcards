require "rails_helper"
require "helpers"

describe "card training process", type: :feature do 
  before :each do

  	card = create(:card)
    allow_any_instance_of(Card).to receive(:review_date).and_return(Date.today.days_ago(4))
  end

  it "card checking out" do
    visit "home"
    fill_in "compared_text", with: 'Mom'
    
    click_button "Проверить"
    expect(page).to have_content 'Верно!'

  end
end