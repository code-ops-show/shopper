module ItemsHelper
  def full_price item
    number_to_currency(item.product_price * item.quantity)
  end
end