class Deck < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { case_sensitive: false, scope: :user_id }
  has_many :cards, dependent: :destroy
  belongs_to :user
  scope :current, -> {where(active: true)}

  def activate!
    self.user.decks.current.last.update_columns(active: false) if self.user.decks.current.exists?
    update_columns(active: true)
  end
end
