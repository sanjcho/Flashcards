require "rails_helper"
require "helpers"

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
    it "passwor must be confirmed" do
      user = build(:user, email:"mail@mail.ru", password:"password", password_confirmation:"Password")
      expect(user.valid?).to be false
      expect(user.errors[:password_confirmation].any?).to be true
    end

  end
end