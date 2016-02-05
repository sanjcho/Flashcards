class AddActiveToDeck < ActiveRecord::Migration
  def change
    add_column :decks, :active, :boolean
  end
end
