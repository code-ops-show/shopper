class ShippingRate < ActiveRecord::Base
  has_many :countries

  attr_accessible :name, :rate
end