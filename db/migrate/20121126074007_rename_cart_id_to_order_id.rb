class RenameCartIdToOrderId < ActiveRecord::Migration
  def change
    rename_column :items, :cart_id, :order_id
  end
end
