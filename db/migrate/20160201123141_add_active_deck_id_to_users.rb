class AddActiveDeckIdToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :active_deck_id, :integer
  end
end
