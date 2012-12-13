class Item < ActiveRecord::Base
  belongs_to :product
  belongs_to :order
  
  attr_accessible :quantity, :increment, :new_quantity
  attr_accessor :increment, :new_quantity

  validates :product_id, uniqueness: { scope: [:order_id] } 
  validates :quantity,  numericality: { less_than_or_equal_to: :product_quantity, 
                                        message: "Number is over product quantity" }
                                        
  validates :quantity, numericality: { greater_than: 0, message: "Quantity must be greater than 0" }

  before_validation :increment_quantity, if: :increment

  delegate :quantity, to: :product, prefix: true

  def increment_quantity
    self.quantity = quantity + new_quantity.to_i
  end

  def unit_price
    product.price
  end

  def full_price
    unit_price * quantity
  end
end