if $('#view_cart').length > 0
  $('#item_<%= @item.id %>').replaceWith("<%= j render 'items/form', item: @item %>")
  $('#item_<%= @item.id %> td').effect('highlight', {}, 400)
else
  $("#product_<%= @item.product.id %>").replaceWith("<%= j render @item.product %>")
  $("#product_<%= @item.product.id %>").find('.caption').effect('highlight', {}, 2000)

Cart.update(<%= current_order.items_count %>)
Cart.setSubTotal("<%= number_to_currency(current_order.total) %>")
Cart.setTotal("<%= number_to_currency(@total) %>")
$('#current-total').effect('highlight', {}, 400)