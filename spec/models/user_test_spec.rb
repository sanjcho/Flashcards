require "rails_helper"
require "helpers"
require "spec_helper"

RSpec.describe User, type: :model do
  context "validates" do
    it "email must be present" do
      user = user_new("", "password")
      expect(user.valid?).to be false
      expect(user.errors[:email].any?).to be true
    end
    it "password must be present" do
      user = user_new("email@mail.ru", "")
      expect(user.valid?).to be false
      expect(user.errors[:password].any?).to be true
    end
    it "email must be unique" do
      user = user_new("email@mail.ru", "password")
      user.save
      user = user_new("email@mail.ru", "elsepassword")
      expect(user.valid?).to be false
      expect(user.errors[:email].any?).to be true
    end
    it "email must be case insensitive unique" do
      user = user_new("email@mail.ru", "password")
      user.save
      user = user_new("EMAIL@mail.ru", "elsepassword")
      expect(user.valid?).to be false
      expect(user.errors[:email].any?).to be true
    end    
    it "email must have correct format" do
      user = user_new("mail", "password")
      expect(user.valid?).to be false
      expect(user.errors[:email].any?).to be true
    end
    it "password length must not be less than 3" do
      user = user_new("mail@mail.ru", "pa")
      expect(user.valid?).to be false
      expect(user.errors[:password].any?).to be true
    end
    it "password must be confirmed" do
      user = build(:user, email:"mail@mail.ru", password:"password", password_confirmation:"Password")
      expect(user.valid?).to be false
      expect(user.errors[:password_confirmation].any?).to be true
    end
    it "password confirmation must be present" do
      user = build(:user, email:"mail@mail.ru", password:"password", password_confirmation: nil)
      expect(user.valid?).to be false
      expect(user.errors[:password_confirmation].any?).to be true
    end
  end
  context "Other_methods" do
    it ".have_expired_card_mail" do
      user = create(:user, email: "newmail@mail.ru")
      deck = create(:deck, user: user)
      card = create(:card, user: user, deck: deck)
      expect{ User.have_expired_card_mail }.to change{ ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end