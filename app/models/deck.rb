class Deck < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { case_sensitive: false, scope: :user_id }
  has_many :cards, dependent: :destroy
  belongs_to :user
  scope :current, -> {where(active: true)}

  def activate!
    self.user.decks.update_all(active: false)
    update_columns(active: true)
  end
end
