$('#user_addresses').html("<%= j render 'addresses/addresses' %>")
$('#checkout').html("<%= j render 'carts/edit', cart: current_order.reload %>")

$('#modal').modal('hide') if $('#modal').length > 0
$('#address_<%= @address.id %>').effect('highlight', {}, 1800)

Cart.setup() if $('#checkout').length > 0