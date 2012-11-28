class Address < ActiveRecord::Base
  belongs_to  :user
  has_many    :orders

  validates :street_address, :city, :state, :zip, :country, :phone, :email, :user_id, presence: true
  attr_accessible :street_address, :city, :state, :zip, :country, :phone, :email, :user_id
  accepts_nested_attributes_for :orders
end