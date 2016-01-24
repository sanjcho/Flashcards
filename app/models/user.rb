class User < ActiveRecord::Base
  authenticates_with_sorcery!
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: {minimum: 3}, confirmation: true
  has_many :cards, dependent: :destroy
end
