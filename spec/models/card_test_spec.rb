require "rails_helper"
require "helpers"

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe Card,:type => :model do
  context "card methods tests" do
    it "Card object with the same original and translated text creation" do
      c=card_new("mom", "Mom")
      expect(c.save).to be false
    end

    it "Actualising review date without DB update" do
    	expect(card_new("mom", "мама").review_actualize.to_i).to eq DateTime.now.days_since(3).to_i
    end

    it "Original text compared with the some inout text" do
      c=card_new("mom", "мама")
      expect(c.original_text_equal_to?("mom")).to be true
    end

    it "Updating review_date with direct DB correction" do
      c=card_new("mom", "мама")
      c.save
      c.update_review_date!
      expect(Card.find(c.id).review_date.to_s).to eq Date.today.days_since(3).to_s
    end
  end
end