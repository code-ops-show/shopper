$('#shipping').html("<%= j render 'shipping', cart: @cart %>")

$('#current-total').find('.content').html("<%= j render 'current_total', cart: @cart %>")
$('#current-total').effect('highlight', {}, 400)
Cart.setShipping()