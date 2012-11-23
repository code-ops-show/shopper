class Purchase < Order
  belongs_to :user

  after_create: purchased

  def update_quantity_for purchase
    Product.update_attributes(quntity: )
  end
end