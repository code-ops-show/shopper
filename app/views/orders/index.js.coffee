$('body').append("<div id=\"view_cart\" class='modal hide fade in cart'></div>") if $('#modal').length is 0
$('#view_cart').html("<%= j render(current_order.items.present? ? 'orders/cart' : 'orders/cart_empty') %>")
$('#view_cart').modal('show')