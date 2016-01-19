require "rails_helper"
require "helpers"

RSpec.describe Card,:type => :model do
  context "validates" do
    it "#must_not_be_equal" do
      card = card_new("mom", "Mom")
      expect(card.valid?).to be false
      expect(card.errors[:original_text].any?).to be true
    end

    it "review_date must be present" do
      allow_any_instance_of(Card).to receive(:review_date).and_return(nil)
      card = card_new("mom", "мама")
      card.review_date = nil
      expect(card).to be_invalid
    end

    it "original_text must be present" do
      card = card_new("", "mom")
      expect(card).to be_invalid
      expect(card.errors[:original_text].any?).to be true
    end

    it "translated_text must be present" do
      card = card_new("mom", "")
      expect(card).to be_invalid
      expect(card.errors[:translated_text].any?).to be true
    end

    it "original_text  must be unique" do
      card = card_new("mom", "мама")
      card.save
      expect(card = card_new("mom", "мамочка")).to be_invalid
      expect(card.errors[:original_text].any?).to be true
    end

    it "translated_text must be unique" do
      card = card_new("mom", "мама")
      card.save
      expect(card = card_new("mammy", "Мама")).to be_invalid
      expect(card.errors[:translated_text].any?).to be true
    end
  end

  context "other methods" do

    it "#review_actualize" do
      expect(card_new("mom", "мама").review_actualize.to_i).to eq DateTime.now.days_since(3).to_i
    end

    it "#original_text_equal_to?" do
      card = card_new("mom", "мама")
      expect(card.original_text_equal_to?("mom")).to be true
    end

    it "#update_review_date!" do
      card = card_new("mom", "мама")
      card.save
      card.update_review_date!
      expect(Card.find(card.id).review_date.to_s).to eq Date.today.days_since(3).to_s
    end
  end
end
