class Deck < ActiveRecord::Base
validates :name, presence: true, uniqueness: { case_sensitive: false, scope: :user_id }
has_many :cards, dependent: :destroy


end
