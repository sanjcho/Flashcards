class AddExemplumToCards < ActiveRecord::Migration
  def change
    add_column :cards, :exemplum, :string
  end
end
