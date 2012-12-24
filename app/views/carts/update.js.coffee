state = "<%= @cart.state %>"
switch state
  when 'purchased' then window.location = '/'
  when 'cart'
    $('#view_cart.modal').html("<%= j render(current_order.items.present? ? 'show' : 'show_empty') %>")
    $('#checkout').html("<%= j render 'edit', cart: @cart.reload if current_user %>")
    $('#current-total').effect('highlight', {}, 400)

    Cart.setup() if $('#view_cart.modal').length is 0
    Cart.update(<%= current_order.reload.items_count %>)