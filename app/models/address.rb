class Address < ActiveRecord::Base
  belongs_to  :user
  has_many    :orders

  validates :street_address, :city, :state, :zip, :country, :phone, :email, :user_id, presence: true
  attr_accessible :street_address, :city, :state, :zip, :country, :phone, :email, :user_id, :default
  accepts_nested_attributes_for :orders

  after_create :set_default, if: -> { user.addresses.size.eql?(1) or self.default }
  after_update :set_default, if: -> { self.default_changed? and self.default and user.addresses.size > 1 }

  def set_default
    user.addresses.size.eql?(1) ? self.update_attributes(default: true) :  Address.where(user_id: user.id, default: true).first.update_attributes(default: false)
  end
end