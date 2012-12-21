$("#product_<%= @item.product.id %>").replaceWith("<%= j render @item.product %>")
$("#product_<%= @item.product.id %>").find('.caption').effect('highlight', {}, 2000)

Cart.update(<%= current_order.reload.items_count %>)
Cart.setSubTotal("<%= number_to_currency(current_order.total) %>")
Cart.setTotal("<%= number_to_currency(@balance) %>")
$('#current-total').effect('highlight', {}, 400)