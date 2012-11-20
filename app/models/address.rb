class Address < ActiveRecord::Base
  validates :street_address, :city, :state, :zip, :country, :phone, :email, :user_id, presence: true
  attr_accessible :street_address, :city, :state, :zip, :country, :phone, :email, :user_id
end