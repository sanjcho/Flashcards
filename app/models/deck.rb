class Deck < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { case_sensitive: false, scope: :user_id }
  has_many :cards, dependent: :destroy
  belongs_to :user
  scope :current, -> {where(active: true).first}

  def activate_it!
    self.user.decks.current.update_columns(active: false)
    update_columns(active: true)
  end
end
