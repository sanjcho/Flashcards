require "rails_helper"
require "helpers"

RSpec.configure do |c|
  c.include Helpers
end

RSpec.describe Card,:type => :model do
  context "card methods tests" do
    it "validate :must_not_be_equal test" do
      card = card_new("mom", "Mom")
      expect(card).to be_invalid
    end

    it "validates :review_date, presence: true test" do
      card = card_new("mom", "Mom")
      card.review_date = nil
      expect(card).to be_invalid
    end

    it "validates :original_text and :translated_text presence test" do
      expect(card_new("", "mom")).to be_invalid
      expect(card_new("Daddy", "")).to be_invalid
    end

    it "validates :original_text and :translated_text uniqueness test" do
      card = card_new("mom", "мама")
      card.save
      expect(card_new("mom", "мамочка")).to be_invalid
      expect(card_new("mommy", "мама")).to be_invalid
    end

    it ".review_actualize test" do
      expect(card_new("mom", "мама").review_actualize.to_i).to eq DateTime.now.days_since(3).to_i
    end

    it ".original_text_equal_to? test" do
      card = card_new("mom", "мама")
      expect(card.original_text_equal_to?("mom")).to be true
    end

    it ".update_review_date! test" do
      card = card_new("mom", "мама")
      card.save
      card.update_review_date!
      expect(Card.find(card.id).review_date.to_s).to eq Date.today.days_since(3).to_s
    end
  end
end
