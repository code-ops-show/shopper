$('#user_addresses').html("<%= j render 'addresses/addresses' %>")
$('#shipping').html("<%= j render 'carts/addresses/shipping', cart: current_order %>")
$('#modal').modal('hide') if $('#modal').length > 0
$('#address_<%= @address.id %>').effect('highlight', {}, 1800)