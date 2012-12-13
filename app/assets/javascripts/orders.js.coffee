$(document).ready ->
  Cart.setup()

window.Cart =
  setup: ->
    timer = null
    $('#view_cart').on 'input', 'input[name*="item[quantity]"]', (e) ->
      if timer then clearTimeout(timer)
      timer = setTimeout => 
          $.ajax
            url: $(@).parent('form').attr('action')
            dataType: 'script'
            data: $(@).parent('form').serialize()
            type: "POST"
            error: (jqXHR, textStatus, error) =>
              $(@).effect('highlight', {}, 2000)
              $(@).val($(@).data('quantity'))
        , 800


  update: (quantity = 0) ->
    cart = $('.navbar').find('.cart a')
    cart.stop(true, true).effect('pulsate')
    cart.html("<i class=\"icon-shopping-cart icon-white\"></i> Cart (#{quantity})")