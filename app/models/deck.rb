class Deck < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { case_sensitive: false, scope: :user_id }
  has_many :cards, dependent: :destroy
  belongs_to :user

  def activate_process
    self.active = true
    self.save
    user = self.user
    user.active_deck_id = self.id
    user.save
  end

  def deactivate_process
  	self.active = false
  	self.save
  end

  def user_active_id_delete
  	user = self.user
  	user.active_deck_id = nil
  	user.save
  end

end
