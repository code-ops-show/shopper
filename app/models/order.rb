class Order < ActiveRecord::Base
  include Order::Stateful

  belongs_to :address
  has_many   :items,    order: 'created_at ASC'
  has_many   :products, through: :items

  attr_accessible :state, :token, :address_id, :address_attributes, :items_attributes, :state_event, :guest_email
  attr_accessor :guest_email

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :items

  delegate :email, to: :address

  alias_method :order_email, :email

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