class RemCorWrongAddIntervalRepeateEFactorToCards < ActiveRecord::Migration
  def up
    remove_column :cards, :correct
    remove_column :cards, :wrong
    add_column :cards, :e_factor, :float, default: 2.5
    add_column :cards, :repeate, :integer, default: 1
    add_column :cards, :interval, :float
  end
 
  def down
    add_column :cards, :correct, :integer
    add_column :cards, :wrong, :integer
    remove_column :cards, :e_factor
    remove_column :cards, :repeate
    remove_column :cards, :interval
  end
end
