class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end
  validates :email, presence: true, uniqueness: { case_sensitive: false },email_format: { message: :mail_format_wrong }
  validates :password, length: {minimum: 3}, confirmation: true, if: :new_record?
  validates :password_confirmation, presence: true
  has_many :cards, dependent: :destroy
  has_many :decks, dependent: :destroy
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications


  def card_choose
    if self.decks.current.exists?
      self.decks.current.first.cards.expired.random.first 
    else
      self.cards.expired.random.first
    end


  end
end
