class Order < ActiveRecord::Base
  belongs_to :address
  has_many   :items,    order: 'created_at ASC'
  has_many   :products, through: :items

  attr_accessible :state, :token, :address_id, :address_attributes, :items_attributes, :state_event
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :items

  scope :open_orders, -> { with_state(:cart) }

  state_machine initial: :cart do
    before_transition cart: :purchased, do: :validates_cart
    after_transition cart: :purchased, do: :something

    event :purchase do
      transition cart: :purchased
    end

    event :cancel do
      transition purchased: :canceled
    end

    event :ship do
      transition purchased: :shipped
    end
  end

  def validates_cart
    address_id.present? and item.present?
  end

  def somthing
  end
  
  def get_balance
    total + ((not address or address.new_record?) ? 0 : address.rate)
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