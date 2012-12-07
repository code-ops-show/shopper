class Item < ActiveRecord::Base
  belongs_to :product
  belongs_to :order
  
  attr_accessible :product_id, :quantity

  def unit_price
    product.price
  end
  
  def full_price
    unit_price * quantity
  end

  def update_quantity(item_quantity)
    self.update_attributes(quantity: amount_for(item_quantity)) if amount_for(item_quantity) <= product.quantity
  end

private
  def amount_for item_quantity
    quantity + item_quantity.to_i
  end
end