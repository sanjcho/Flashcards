require "rails_helper"
require "helpers"
require "spec_helper"
#to run test    rspec spec/models 
RSpec.describe Deck,:type => :model do
  before :context do
    #puts User.last.email
    user_deck_and_card_create
  end
  context "validates" do
  
    it "name must be present" do
      deck = @user.decks.new
      expect(deck.valid?).to be false
      expect(deck.errors[:name].any?).to be true
    end
    it "name must be unique" do
      deck = @user.decks.new(name: "test")
      expect(deck.valid?).to be false
      expect(deck.errors[:name].any?).to be true
    end
  end
  
  context "methods_test" do
    it "activate_it! must make activate Deck, and make inactive current deck (if exist)" do
      deck_old = create(:deck, user: @user, name: 'somedackname', active: true)
      @deck.activate_it!
      expect(@deck.active).to be true
      expect(Deck.find(deck_old.id).active).to be false
    end
  end


end