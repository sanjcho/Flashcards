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

    it "#original_text_equal_to?" do
      card = card_new("mom", "мама")
      expect(card.original_text_equal_to?("mom")).to be true
    end

    it "#update_review_date! if there are a first correct answer" do
      card = card_new("mom", "мама")
      card.save
      card.update_columns(correct: 0)
      card.update_review_date!
      expect(Card.find(card.id).review_date.in_time_zone("Ekaterinburg").beginning_of_minute).to eq DateTime.now.in_time_zone("Ekaterinburg").beginning_of_minute + 12.hours
    end
    it "#update_review_date! if there are the second correct answer" do
      card = card_new("mom", "мама")
      card.save
      card.update_columns(correct: 1)
      card.update_review_date!
      expect(Card.find(card.id).review_date.in_time_zone("Ekaterinburg").beginning_of_minute).to eq DateTime.now.in_time_zone("Ekaterinburg").beginning_of_minute + 3.days
    end
    it "#update_review_date! if there are the third correct answer" do
      card = card_new("mom", "мама")
      card.save
      card.update_columns(correct: 2)
      card.update_review_date!
      expect(Card.find(card.id).review_date.in_time_zone("Ekaterinburg").beginning_of_minute).to eq DateTime.now.in_time_zone("Ekaterinburg").beginning_of_minute + 7.days
    end
    it "#update_review_date! if there are the 4th correct answer" do
      card = card_new("mom", "мама")
      card.save
      card.update_columns(correct: 3)
      card.update_review_date!
      expect(Card.find(card.id).review_date.in_time_zone("Ekaterinburg").beginning_of_minute).to eq DateTime.now.in_time_zone("Ekaterinburg").beginning_of_minute + 14.days
    end
    it "#update_review_date! if there are the 5th correct answer" do
      card = card_new("mom", "мама")
      card.save
      card.update_columns(correct: 4)
      card.update_review_date!
      expect(Card.find(card.id).review_date.in_time_zone("Ekaterinburg").beginning_of_minute).to eq DateTime.now.in_time_zone("Ekaterinburg").beginning_of_minute + 1.month
    end
    it "#check_on_error! if there is a first error" do
      card = card_new("mom", "мама")
      card.save
      card.update_columns(wrong: 0)
      card.check_on_error!
      expect(Card.find(card.id).wrong).to be 1
    end
    it "#check_on_error! if there is a first error" do
      card = card_new("mom", "мама")
      card.save
      card.update_columns(wrong: 2, correct: 3)
      card.check_on_error!
      expect(Card.find(card.id).wrong).to be 0
      expect(Card.find(card.id).correct).to be 0
    end
    it "cor_wrong_setup" do
      card = card_new("mom", "мама")
      card.save
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