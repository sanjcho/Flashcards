require "rails_helper"
require "helpers"
require "spec_helper"
#to run test    rspec spec/models 
RSpec.describe Card,:type => :model do
  before :context do
    user = create(:user, email: "someemail2@mail.ru", password: "somepassword", password_confirmation: "somepassword")
    deck = create(:deck, user: user, name: "somename")
  end
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

    it "original&translated text diff user  must not be unique" do
      card = card_new("mom", "мама")
      card.save
      user = create(:user, email:"someanothermail@mail.ru", password:"somepassword", password_confirmation:"somepassword")
      deck = create(:deck, user: user, name: "someelsename")
      expect(card = build(:card, deck: deck, user: user, original_text: "mom", translated_text: "мама")).to be_valid
    end

    it "translated_text must be unique" do
      card = card_new("mom", "мама")
      card.save
      expect(card = card_new("mammy", "Мама")).to be_invalid
      expect(card.errors[:translated_text].any?).to be true
    end
    it "user_id must be present" do
      card = Card.new(original_text: "something", translated_text: "кое-что")
      expect(card.valid?).to be false
      expect(card.errors[:user_id].any?).to be true
    end

    it "card_id must be present" do
      card = Card.new(original_text: "something", translated_text: "кое-что")
      expect(card.valid?).to be false
      expect(card.errors[:deck_id].any?).to be true
    end

  end

  context "other methods" do

    it "#review_actualize" do
      expect(card_new("mom", "мама").review_actualize.to_i).to eq DateTime.now.to_i
    end
    it "#cor_wrong_setup" do
      card = card_new("mom", "мама")
      card.save
      expect(Card.find(card.id).wrong).to be 0
      expect(Card.find(card.id).correct).to be 0
    end
  
  end

  context "CardComparator class" do

    it "CardComparator#call must return true if texts is equal" do
      card = card_new("mom", "мама")
      card.save
      expect(CardComparator.call(card: card, compared_text: "mom")).to be true
    end

    it "CardComparator#call must return false if texts is not equal" do
      card = card_new("mom", "мама")
      card.save
      expect(CardComparator.call(card: card, compared_text: "dad")).to be false
    end

    it "CardComparator#call must increase card.correct on 1 and review_date on 12 hours if there is a first correct answer" do
      card = card_new("mom", "мама")
      card.correct = 0
      card.save
      expect(CardComparator.call(card: card, compared_text: "mom")).to be true
      expect(Card.find(card.id).review_date.in_time_zone("Ekaterinburg").beginning_of_minute).to eq DateTime.now.in_time_zone("Ekaterinburg").beginning_of_minute + 12.hours
      expect(Card.find(card.id).correct).to be 1
    end
    it "CardComparator#call must increase card.correct on 1 and review_date on 3 days if there is a 2nd correct answer" do
      card = card_new("mom", "мама")
      card.save
      card.update(correct: 1)
      expect(CardComparator.call(card: card, compared_text: "mom")).to be true
      expect(Card.find(card.id).review_date.in_time_zone("Ekaterinburg").beginning_of_minute).to eq DateTime.now.in_time_zone("Ekaterinburg").beginning_of_minute + 3.days
      expect(Card.find(card.id).correct).to be 2
    end
    it "CardComparator#call must increase card.correct on 1 and review_date on 7 days if there is a 3rd correct answer" do
      card = card_new("mom", "мама")
      card.save
      card.update(correct: 2)
      expect(CardComparator.call(card: card, compared_text: "mom")).to be true
      expect(Card.find(card.id).review_date.in_time_zone("Ekaterinburg").beginning_of_minute).to eq DateTime.now.in_time_zone("Ekaterinburg").beginning_of_minute + 7.days
      expect(Card.find(card.id).correct).to be 3
    end
    it "CardComparator#call must increase card.correct on 1 and review_date on 14 days if there is a 4th correct answer" do
      card = card_new("mom", "мама")
      card.save
      card.update(correct: 3)
      expect(CardComparator.call(card: card, compared_text: "mom")).to be true
      expect(Card.find(card.id).review_date.in_time_zone("Ekaterinburg").beginning_of_minute).to eq DateTime.now.in_time_zone("Ekaterinburg").beginning_of_minute + 14.days
      expect(Card.find(card.id).correct).to be 4
    end
    it "CardComparator#call must increase card.correct on 1 and review_date on 1 month if there is a 5th correct answer" do
      card = card_new("mom", "мама")
      card.save
      card.update(correct: 4)
      expect(CardComparator.call(card: card, compared_text: "mom")).to be true
      expect(Card.find(card.id).review_date.in_time_zone("Ekaterinburg").beginning_of_minute).to eq DateTime.now.in_time_zone("Ekaterinburg").beginning_of_minute + 1.month
      expect(Card.find(card.id).correct).to be 5
    end
    it "CardComparator#call must increase wrong on 1 if there is a first wrong answer" do
      card = card_new("mom", "мама")
      card.save
      card.update(wrong: 0)
      expect(CardComparator.call(card: card, compared_text: "dad")).to be false
      expect(Card.find(card.id).wrong).to be 1
    end
    it "CardComparator#call must increase wrong on 1 and reset correct to 0 if there is a 3rd wrong answer" do
      card = card_new("mom", "мама")
      card.save
      card.update(wrong: 2)
      expect(CardComparator.call(card: card, compared_text: "dad")).to be false
      expect(Card.find(card.id).wrong).to be 0
      expect(Card.find(card.id).correct).to be 0
    end

  end

  context "dependent" do
    it "dependent destroy of user" do
      card = card_new("mom", "мама")
      card.save
      User.first.destroy
      expect(Card.exists?).to be false
    end
  end
end