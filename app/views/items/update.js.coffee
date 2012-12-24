$("#product_<%= @item.product.id %>").replaceWith("<%= j render @item.product %>")
$("#product_<%= @item.product.id %>").find('.caption').effect('highlight', {}, 2000)

$('#checkout').html("<%= j render 'carts/edit', cart: @item.order.reload if current_user %>")
Cart.setup() if $('#view_cart.modal').length is 0
Cart.update(<%= current_order.reload.items_count %>)
$('#current-total').effect('highlight', {}, 400)