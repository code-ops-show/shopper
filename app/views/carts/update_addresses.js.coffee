<%= puts (current_user ? 'carts/addresses/shipping' : 'carts/addresses/shipping_guest') %>
$('#shipping').html("<%= j render (current_user ? 'carts/addresses/shipping' : 'carts/addresses/shipping_guest'), cart: @cart %>")

$('#current-total').effect('highlight', {}, 400) if Cart.shippingChanged()
$('#current-total').find('.content').html("<%= j render 'current_total', cart: @cart %>")

Cart.setShipping()