class Item < ActiveRecord::Base
  belongs_to :product
  belongs_to :order
  
  attr_accessible :product_id, :quantity

  def unit_price
    product.price
  end
  
  def full_price
    unit_price*quantity
  end

  def update_quantity(item_quantity)
    self.update_attributes(quantity: amout_for(item_quantity)) if amout_for(item_quantity) <= self.product.quantity
  end

private
  def amout_for item_quantity
    self.quantity + item_quantity.to_i
  end
end