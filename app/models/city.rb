class City < ActiveRecord::Base
  belongs_to :country

  attr_accessible :country_id, :name
end