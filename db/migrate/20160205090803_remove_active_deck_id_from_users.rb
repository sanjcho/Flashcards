class RemoveActiveDeckIdFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :active_deck_id
  end
end
