class RenameCartItems < ActiveRecord::Migration
  def change
    rename_table :cart_items, :items
  end
end
