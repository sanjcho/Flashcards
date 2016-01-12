class TextComparisonValidator < ActiveModel::Validator
  def validate(record)
    if record.original_text.downcase == record.translated_text.downcase
      record.errors.add( :original_text,:must_be_diff_w_transl)
    end
  end
end
class Card < ActiveRecord::Base
validates :original_text, :translated_text, presence: true, uniqueness: { case_sensitive: false }
validates :review_date, presence: true
validates_with TextComparisonValidator
  before_validation do
    self.review_date = DateTime.now.days_since(3)
  end
end
