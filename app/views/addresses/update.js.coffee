$('#user_addresses').html("<%= j render 'addresses/addresses' %>")
$('#modal').modal('hide') if $('#modal').length > 0
$('#address_<%= @address.id %>').effect('highlight', {}, 1800)