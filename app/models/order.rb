class Order < ActiveRecord::Base
  has_many   :items
  belongs_to :address
  has_many   :products,     through: :items

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
    cart = Order.where(token: token, state: 'cart').includes(items: [:product]).first
    cart.touch if cart.present?
    cart
  end

  def total_price
    items.to_a.sum(&:full_price)
  end
end