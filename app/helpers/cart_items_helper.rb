module CartItemsHelper
  def full_price cart_item
    number_to_currency(cart_item.unit_price*cart_item.quantity)
  end
end