class User < ActiveRecord::Base
  authenticates_with_sorcery!
  validates :email, presence: true, uniqueness: { case_sensitive: false },email_format: { message: :mail_format_wrong }
  validates :password, length: {minimum: 3}, confirmation: true
  has_many :cards, dependent: :destroy
end
