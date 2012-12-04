$(document).ready ->
  timer = null
  $('#view_cart').on 'input', 'input[name*="item[quantity]"]', (e) ->
    if timer then clearTimeout(timer)
    timer = setTimeout (=> $(@).parent('form').submit()), 800

window.Cart =
  update: (quantity = 0) ->
    cart = $('.navbar').find('.cart a')
    cart.stop(true, true).effect('pulsate')
    cart.html("<i class=\"icon-shopping-cart icon-white\"></i> Cart (#{quantity})")