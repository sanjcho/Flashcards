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
      user = user_new("email", "")
      expect(user.valid?).to be false
      expect(user.errors[:password].any?).to be true
    end
    it "email must be unique" do
      user = user_new("email", "password")
      user.save
      user = user_new("email", "elsepassword")
      expect(user.valid?).to be false
      expect(user.errors[:email].any?).to be true
    end
  end
end
