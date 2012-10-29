class Product < ActiveRecord::Base
  belongs_to :category
  has_many   :cart_items

  mount_uploader :cover, ImageUploader

  attr_accessible :category_id, :name, :description, :quantity, :price, :cover


  scope :last_four_products, order('created_at DESC').limit(4)

end