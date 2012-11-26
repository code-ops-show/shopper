module ItemsHelper
  def full_price item
    number_to_currency(item.unit_price*item.quantity)
  end
end