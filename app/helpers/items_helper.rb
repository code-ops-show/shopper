module ItemsHelper
  def full_price item
    number_to_price(item.product_price * item.quantity)
  end
end