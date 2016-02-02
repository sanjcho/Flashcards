class Deck < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { case_sensitive: false, scope: :user_id }
  has_many :cards, dependent: :destroy
  belongs_to :user

  def activate_process!
    #self.active = true
    #self.save
    update_columns(active: true)
    user = self.user
    user.update_columns(active_deck_id: self.id)
    #user.active_deck_id = self.id
    #user.save
  end

  def deactivate_process!
  	update_columns(active: false)
  	#self.active = false
  	#self.save
  end

  def user_active_id_delete!
  	user = self.user
  	user.update_columns(active_deck_id: nil)
  end

end
