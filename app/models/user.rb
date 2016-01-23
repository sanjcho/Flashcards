class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true
  has_many :cards, dependent: :destroy
end
