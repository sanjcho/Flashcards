class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end
  validates :email, presence: true, uniqueness: { case_sensitive: false },email_format: { message: :mail_format_wrong }
  validates :password, length: {minimum: 3}, confirmation: true, if: :new_user?
  has_many :cards, dependent: :destroy
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications
  
  private
  def new_user?
    new_record?
  end

end
