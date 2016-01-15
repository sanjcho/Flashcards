class Card < ActiveRecord::Base
validates :original_text, :translated_text, presence: true, uniqueness: { case_sensitive: false }
validates :review_date, presence: true
validate :must_not_be_equal
scope :expired, ->{ where('review_date <= ?', DateTime.now }
#attr_accessible :compared_text  
  before_validation(on: :create) do
    self.review_date = DateTime.now.days_since(3)
  end

  def self.random
    offset(rand(count))
  end

  def must_not_be_equal
    if self.original_text.downcase == self.translated_text.downcase
      self.errors.add( :original_text,:must_be_diff_w_transl)
    end
  end



end
