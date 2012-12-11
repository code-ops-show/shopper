class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :products

  mount_uploader :cover, ImageUploader

  attr_accessible :name, :description, :cover
end