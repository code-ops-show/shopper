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
end