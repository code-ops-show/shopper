$('#edit_order_<%= @cart.id %>').html("<%= j render 'form' %>")

Cart.setShipping()
Cart.setSubTotal("<%= number_to_currency(current_order.total) %>")
Cart.setTotal("<%= number_to_currency(@total) %>")
$('#current-total').effect('highlight', {}, 400)