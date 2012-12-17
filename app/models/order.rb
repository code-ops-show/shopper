class Order < ActiveRecord::Base
  belongs_to :address
  has_many   :items
  has_many   :products, through: :items

  attr_accessible :state, :token, :address_id, :address_attributes
  accepts_nested_attributes_for :address

  scope :open_orders, -> { with_state(:cart) }

  state_machine initial: :cart do
    event :purchase do
      transition :cart => :purchased
    end

    event :cancel do
      transition :purchased => :canceled
    end

    event :resume do
      transition :canceled => :purchased
    end

    event :ship do
      transition :purchased => :shipped
    end
  end

  def self.cart_by token
    Order.where(token: token, state: 'cart').includes(items: [:product]).first
  end

  def calculate_items
    self.items_count = items.sum(&:quantity)
    self.total = items.sum(&:sub_total)
    self.save
  end
end