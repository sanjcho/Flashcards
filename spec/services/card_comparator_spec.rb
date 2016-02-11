require "rails_helper"
require "helpers"
require "spec_helper"

  describe CardComparator do
  	before :each do
      user = create(:user, email: "someemail2@mail.ru", password: "somepassword", password_confirmation: "somepassword")
      deck = create(:deck, user: user, name: "somename")
      @card = card_new("mom", "мама")
      @card.save
      @comparator = CardComparator.new(card: @card, compared_text: "mom")
    end

    context "#diff method" do
      
      it "#diff must return 0 if texsts is equal" do
        expect(@comparator.diff).to be 0
      end

      it "#diff must return 1 if texsts have one type error" do
        comparator = CardComparator.new(card: @card, compared_text: "mam")
        expect(comparator.diff).to be 1
      end

      it "#diff must return false if texsts is not equal" do
        comparator = CardComparator.new(card: @card, compared_text: "daddy")
        expect(comparator.diff).to be 3
      end
    end

    context "#update_card_attr_right! method" do
     
      it "#update_card_attr_right! must increase card.correct on 1 and review_date on 12 hours if there is a first correct answer" do
        @comparator.update_card_attr_right!(@card)
        expect(Card.find(@card.id).review_date.beginning_of_minute).to eq 12.hours.from_now.beginning_of_minute
        expect(Card.find(@card.id).correct).to be 1
      end
      it "#update_card_attr_right! must increase card.correct on 1 and review_date on 3 days if there is a 2nd correct answer" do
        @card.update(correct: 1)
        @comparator.update_card_attr_right!(@card)
        expect(Card.find(@card.id).review_date.beginning_of_minute).to eq 3.days.from_now.beginning_of_minute
        expect(Card.find(@card.id).correct).to be 2
      end
      it "#update_card_attr_right! must increase card.correct on 1 and review_date on 7 days if there is a 3rd correct answer" do
        @card.update(correct: 2)
        @comparator.update_card_attr_right!(@card)
        expect(Card.find(@card.id).review_date.beginning_of_minute).to eq 7.days.from_now.beginning_of_minute
        expect(Card.find(@card.id).correct).to be 3
      end
      it "#update_card_attr_right! must increase card.correct on 1 and review_date on 14 days if there is a 4th correct answer" do
        @card.update(correct: 3)
        @comparator.update_card_attr_right!(@card)
        expect(Card.find(@card.id).review_date.beginning_of_minute).to eq 14.days.from_now.beginning_of_minute
        expect(Card.find(@card.id).correct).to be 4
      end
      it "#update_card_attr_right! must increase card.correct on 1 and review_date on 14 days if there is a 4th correct answer" do
        @card.update(correct: 4)
        @comparator.update_card_attr_right!(@card)
        expect(Card.find(@card.id).review_date.beginning_of_minute).to eq 1.month.from_now.beginning_of_minute
        expect(Card.find(@card.id).correct).to be 5
      end
    end
    context "#update_card_attr_right! method" do
      it "#check_on error must increase wrong on 1 if there is a first wrong answer" do
      	@comparator.check_on_error!(@card)
      	expect(Card.find(@card.id).wrong).to be 1
      end
      it "#check_on error must increase wrong on 1 if there is a first wrong answer" do
      	@card.wrong = 2
      	@card.correct = 1
      	@comparator.check_on_error!(@card)
      	expect(Card.find(@card.id).wrong).to be 0
      	expect(Card.find(@card.id).correct).to be 0
      end
    end
    context "#CardComparator.call" do
      
      it ".call must return result.success? = true if texts is equal" do
        result = CardComparator.call(card: @card, compared_text: "mom")
        expect(result.success?).to be true
      end
      it ".call must return result.type_error? = true if texts have 1 error" do
        result = CardComparator.call(card: @card, compared_text: "mam")
        expect(result.type_error?).to be true
      end
      it ".call must return result.success = true if texts is equal" do
        result = CardComparator.call(card: @card, compared_text: "mag")
        expect(result.type_error?).to be true
      end
      it ".call must return result.success = true if texts is equal" do
        result = CardComparator.call(card: @card, compared_text: "dad")
        expect(result.wrong?).to be true
      end
    end
  end