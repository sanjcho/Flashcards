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
    it "activate_process! must make deck active and make user.active_deck_id = deck.id" do
      @deck.activate_process!
      expect(@deck.active).to be true
      expect(@deck.user.active_deck_id).to be @deck.id
    end
    it "deactivate_process! must make deck inactive" do
      @deck.activate_process!
      @deck.deactivate_process!
      expect(@deck.active).to be false
    end
    it "user_active_id_delete! must delete active_deck_id from coresponding user" do
      @deck.activate_process!
      @deck.user_active_id_delete!
      expect(@deck.user.active_deck_id).to be nil
    end

  end


end