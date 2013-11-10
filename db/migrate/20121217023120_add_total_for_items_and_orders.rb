class AddTotalForItemsAndOrders < ActiveRecord::Migration
  def change
    add_column :items,  :sub_total, :float, default: 0
    add_column :orders, :items_count, :integer, default: 0
    add_column :orders, :total, :float, default: 0
    add_column :orders, :balance, :float, default: 0

    Item.reset_column_information
    Item.all.each do |item|
      item.update_attribute :sub_total, item.product_price * item.quantity
    end

    Order.reset_column_information
    Order.all.each do |order|
      order.update_attribute :items_count, order.items.sum(&:quantity)
      order.update_attribute :total, order.items.sum(&:sub_total)
    end
  end
end
