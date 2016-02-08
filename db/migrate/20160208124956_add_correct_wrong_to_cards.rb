class AddCorrectWrongToCards < ActiveRecord::Migration
  def change
    add_column :cards, :correct, :integer
    add_column :cards, :wrong, :integer
  end
end
