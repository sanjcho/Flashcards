class Card < ActiveRecord::Base
  belongs_to :user
  belongs_to :deck
  validates :original_text, :translated_text, presence: true, uniqueness: { case_sensitive: false, scope: :user_id }
  validates :review_date, presence: true
  validates :user_id, presence: true
  validate :must_not_be_equal
  scope :expired, -> { where('review_date <= ?', Date.today) }
  scope :random, -> { offset(rand(count))}
  before_validation(on: :create) do
    review_actualize
  end
  mount_uploader :exemplum, ExemplumUploader

  def must_not_be_equal
    if self.original_text.downcase == self.translated_text.downcase
      self.errors.add( :original_text,:must_be_diff_w_transl)
    end
  end

  def review_actualize
    self.review_date = DateTime.now.days_since(3)
  end

  def original_text_equal_to? (arg)
    original_text.downcase.strip == arg.downcase.strip
  end

  def update_review_date!
    update_columns(review_date: DateTime.now.days_since(3))
  end

end
