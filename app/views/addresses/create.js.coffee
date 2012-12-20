$('#user_addresses').html("<%= j render 'addresses/addresses' %>")
$('#shipping').html("<%= j render (current_user ? 'carts/addresses/shipping' : 'carts/addresses/shipping_guest'), cart: current_order %>")
$('#modal').modal('hide') if $('#modal').length > 0
$('#address_<%= @address.id %>').effect('highlight', {}, 1800)