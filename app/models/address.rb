class Address < ActiveRecord::Base
  belongs_to :user
  belongs_to :country
  has_many   :orders

  scope :default, -> { where(default: true) }

  delegate :rate, to: :country
  delegate :email, to: :user

  validates :street_address, :city, :state, :zip, :country_id, :phone, presence: true
  attr_accessible :street_address, :city, :state, :zip, :country_id, :phone, :user_id, :default
  accepts_nested_attributes_for :orders

  after_create  :set_default, if: -> { default == true or user.addresses.size.eql?(1) }
  before_update :set_default, if: -> { default == true and default_changed? and user.addresses.size > 1 }

  def set_default
    if user.addresses.size.eql?(1) #set first user's address as default
      self.update_attributes(default: true)
    else
      user.default_address.update_attributes(default: false) if user.default_address.present?
    end
  end

  def to_s
    country.name
  end

  def full_address
    "#{street_address} #{city}, #{state} #{zip} #{country.name}"
  end
end