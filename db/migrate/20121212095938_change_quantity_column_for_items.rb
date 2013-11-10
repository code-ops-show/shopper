class ChangeQuantityColumnForItems < ActiveRecord::Migration
  def change
    change_column :items, :quantity, :integer, default: 0
    change_column :products, :quantity, :integer, default: 0
  end
end
