class AddAddressIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :address_id, :integer
  end
end
