$('#shipping').html("<%= j render 'carts/addresses/shipping', cart: @cart %>")

$('#current-total').effect('highlight', {}, 400) if Cart.shippingChanged()
$('#current-total').find('.content').html("<%= j render 'current_total', cart: @cart %>")

Cart.setShipping()