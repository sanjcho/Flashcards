require "rails_helper"
require "helpers"
require "spec_helper"

  describe Result do
    
    it "#success? must be true on diff = 0" do
      result = Result.new(0)
      expect(result.success?).to be true
    end
    
    it "#type_error? must be true on diff = 1" do
      result = Result.new(1)
      expect(result.type_error?).to be true
    end

    it "#type_error? must be true on diff = 2" do
      result = Result.new(2)
      expect(result.type_error?).to be true
    end
    
    it "#wrong? must be true on diff = 3" do
      result = Result.new(3)
      expect(result.wrong?).to be true
    end

  end