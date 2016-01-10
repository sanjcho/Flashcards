class Card < ActiveRecord::Base
validates :original_text, :translated_text, presence: true, uniqueness: { case_sensitive: false }
validates :review_date, presence: true
  before_validation do
    self.review_date = DateTime.now.days_since(3)
  end
end
