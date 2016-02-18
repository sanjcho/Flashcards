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

    context "#review_date_calc" do
      
      it "must reset interval and repeate to 1 and stay efactor the same if answer is incorrect - q < 3" do
        @card.repeate = 4
        @card.interval = 6
        ef_old = @card.e_factor
        @comparator.review_date_calc(2)
        expect(@card.repeate).to be == 1
        expect(@card.interval).to be == 1
        expect(@card.e_factor).to be == ef_old
      end

      it "must increase repeate on 1 if answer is correct q = 5" do
        @card.repeate = 4
        @card.interval = 6
        @comparator.review_date_calc(5)
        expect(@card.repeate).to be == 5
      end
    end
    context "#interval_calc" do
     
      it "must make @card.interval = 1 if @card.repeate = 1 and the answer is absolutely right" do
        @card.repeate = 1
        q = 5
        @comparator.interval_calc(q)
        expect(@card.interval).to eq 1
      end
      it "must make @card.interval = 6 if @card.repeate = 2 and the answer is absolutely right" do
        @card.repeate = 2
        q = 5
        @comparator.interval_calc(q)
        expect(@card.interval).to eq 6
      end
      it "must make @card.interval >6 if @card.repeate = 3, and the answer is absolutely right" do
        @card.repeate = 3
        @card.interval = 6
        q = 5
        @comparator.interval_calc(q)
        expect(@card.interval).to be > 6
      end
    end

    context "#efactor_calc" do
      it "must make efactor greater than it was if q = 5 " do
        old_efactor = @card.e_factor
        q = 5
        @comparator.efactor_calc(q)
        expect(@card.e_factor).to be > old_efactor
      end
      it "must make efactor near the same than it was if q = 4 " do
        old_efactor = @card.e_factor
        q = 4
        @comparator.efactor_calc(q)
        expect((@card.e_factor).round(1)).to be == old_efactor
      end
      it "must make efactor smaller than it was if q = 3 " do
        old_efactor = @card.e_factor
        q = 3
        @comparator.efactor_calc(q)
        expect(@card.e_factor).to be < old_efactor
      end

    end

    context "#CardComparator" do
      
      it ".call must return result.success? = true if texts is equal" do
        result = CardComparator.call(card: @card, compared_text: "mom")
        expect(result.success?).to be true
      end
      it ".call must return result.type_error? = true if texts have 1 error" do
        result = CardComparator.call(card: @card, compared_text: "mam")
        expect(result.type_error?).to be true
      end
      it ".call must return result.type_error? = true if texts have 2 error" do
        result = CardComparator.call(card: @card, compared_text: "mag")
        expect(result.type_error?).to be true
      end
      it ".call must return result.wrong = true if texts is not equal" do
        result = CardComparator.call(card: @card, compared_text: "dad")
        expect(result.wrong?).to be true
      end
    end
  end