class Country < ActiveRecord::Base
  has_many :cities
  belongs_to :shipping_rate

  attr_accessible :name, :shipping_rate_id

  delegate :rate, to: :shipping_rate
end