class Card < ActiveRecord::Base
  belongs_to :user
  belongs_to :deck
  validates :original_text, :translated_text, presence: true, uniqueness: { case_sensitive: false, scope: :user_id }
  validates :review_date, :user_id, :deck_id, :correct, :wrong, presence: true
  validate :must_not_be_equal
  scope :expired, -> { where('review_date <= ?', DateTime.now.in_time_zone("Ekaterinburg")) }
  scope :random, -> { offset(rand(count))}
  before_validation(on: :create) do
    review_actualize
    cor_wrong_setup
  end
  mount_uploader :exemplum, ExemplumUploader

  def must_not_be_equal
    if self.original_text.downcase == self.translated_text.downcase
      self.errors.add( :original_text,:must_be_diff_w_transl)
    end
  end

  def review_actualize
    self.review_date = DateTime.now.in_time_zone("Ekaterinburg")
  end
  
  def cor_wrong_setup
    self.correct = 0
    self.wrong = 0
  end
end
