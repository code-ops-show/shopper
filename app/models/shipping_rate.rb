class ShippingRate < ActiveRecord::Base
  has_and_belongs_to_many :countries
end