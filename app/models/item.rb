class Item < ActiveRecord::Base
  belongs_to :product
  belongs_to :order
  
  attr_accessible :quantity, :increment, :new_quantity
  attr_accessor   :increment, :new_quantity

  before_validation :increment_quantity, if: :increment

  validates :product_id, uniqueness: { scope: [:order_id] } 
  validates :quantity,   numericality: { greater_than: 0, message: "Quantity must be greater than 0" }
  validates :quantity,   numericality: { less_than_or_equal_to: :product_quantity, 
                                         message: "Number is over product quantity" }

  delegate :quantity, :price, to: :product, prefix: true

  before_create :calculate_total
  before_update :calculate_total, if: -> { quantity_changed? }
  after_save    :touch_order,     if: -> { quantity_changed? }
  after_destroy :touch_order

  def calculate_total
    self.sub_total = product_price * quantity
  end

  def increment_quantity
    self.quantity = quantity + new_quantity.to_i
  end

  def touch_order
    order.calculate_items
  end

  def consolidate_stock
    product.quantity -= quantity
    product.save
  end

  def return_stock
    product.quantity += quantity
    product.save
  end
end