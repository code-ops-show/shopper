class RenameCartToOrder < ActiveRecord::Migration
  def change
    rename_table :carts, :orders
  end
end
