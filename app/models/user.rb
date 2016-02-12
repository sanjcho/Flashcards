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
  
  def have_expired_card_mail
    User.where(expired_cards_exists: true).each do |user|
      NotificationMailer.expired_cards_email(user).deliver_now
    end
  end

  def self.expired_cards_mark
    User.each do |user|
      if user.decks.current
        user.update_columns(expired_cards_exists: true) if user.decks.current.cards.expired
      else
        user.update_columns(expired_cards_exists: true) if user.cards.expired
      end
    end
  end

  def self.expired_cards_unmark
    User.each do |user|
      user.update_columns(expired_cards_exists: false)
    end
  end
end

