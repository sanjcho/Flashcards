class Card < ActiveRecord::Base
  belongs_to :user
  belongs_to :deck
  validates :original_text, :translated_text, presence: true, uniqueness: { case_sensitive: false, scope: :user_id }
  validates :review_date, presence: true
  validates :user_id, presence: true
  validates :deck_id, presence: true
  validates :correct, presence: true
  validates :wrong, presence: true
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

  def original_text_equal_to? (arg)
    original_text.downcase.strip == arg.downcase.strip
  end

  def update_review_date!
  count = self.correct
    if count == 0
      update_columns(review_date: DateTime.now.in_time_zone("Ekaterinburg") + 12.hours, correct: self.correct + 1)
    elsif count == 1
      update_columns(review_date: DateTime.now.in_time_zone("Ekaterinburg") + 3.days, correct: self.correct + 1)
    elsif count == 2
      update_columns(review_date: DateTime.now.in_time_zone("Ekaterinburg") + 7.days, correct: self.correct + 1)
    elsif count == 3
      update_columns(review_date: DateTime.now.in_time_zone("Ekaterinburg") + 14.days, correct: self.correct + 1)
    elsif count >= 4
      update_columns(review_date: DateTime.now.in_time_zone("Ekaterinburg") + 1.month, correct: self.correct + 1)
    end
  end



  def cor_wrong_setup
    self.correct = 0
    self.wrong = 0
  end

  def errored?
    wrong >= 2
  end

  def check_on_error!
    if self.errored?  #is there a lot of error made?
      update_columns(correct: 0, wrong: 0)  
      #reset all counters and review_date, start from begin
    else
      update_columns(wrong: self.wrong + 1 )
      #there are no so lot of errors, second or third chanse avaliable
    end
  end

end
