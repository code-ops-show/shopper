class Country < ActiveRecord::Base
  has_many :cities
  has_and_belongs_to_many :shipping_rates

  attr_accessible :name
end