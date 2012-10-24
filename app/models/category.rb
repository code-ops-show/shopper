class Category < ActiveRecord::Base
  has_many :products

  extend FriendlyId
  friendly_id :name, use: :slugged

  mount_uploader :cover, ImageUploader

  attr_accessible :name, :description, :cover

  friendly_id :name, use: :slugged

end