class Address < ActiveRecord::Base
  belongs_to  :user
  has_one     :order

  validates :street_address, :city, :state, :zip, :country, :phone, :email, :user_id, presence: true
end