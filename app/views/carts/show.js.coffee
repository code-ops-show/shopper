if $('#view_cart').length is 0
  $('body').append("<div id=\"view_cart\" class='modal hide fade in cart'></div>")
  Cart.setup()

$('#view_cart').html("<%= j render (current_order.items.present? ? 'show' : 'show_empty'), cart: @cart %>")
$('#view_cart').modal('show')
