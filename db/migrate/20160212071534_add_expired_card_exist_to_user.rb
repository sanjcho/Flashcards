class AddExpiredCardExistToUser < ActiveRecord::Migration
  def change
    add_column :users, :expired_card_exists, :boolean
  end
end
