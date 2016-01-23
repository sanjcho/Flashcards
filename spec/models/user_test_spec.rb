require "rails_helper"
require "helpers"

RSpec.describe Card,:type => :model do
  context "validates" do
    it "email must be present" do
      user = user_new("","password")
      expect(user.valid?).to be false
      expect(user.errors[:email].any?).to be true
    end
  end
end