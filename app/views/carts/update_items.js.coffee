$('#view_cart').find('form').replaceWith("<%= j render 'carts/items/items', cart: @cart %>") if $('#view_cart').length > 0

$('#current-total').find('.content').html("<%= j render 'current_total', cart: @cart.reload %>")
$('#current-total').effect('highlight', {}, 400)

Cart.setShipping()
Cart.update(<%= current_order.reload.items_count %>)