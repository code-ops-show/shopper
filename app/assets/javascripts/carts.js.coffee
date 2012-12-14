$(document).ready ->
  Cart.setup()
  Cart.setShipping()

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
    cart.stop(true, true).effect('pulsate', { times: 3 })
    cart.html("<i class=\"icon-shopping-cart icon-white\"></i> Cart (#{quantity})")

  setSubTotal: (price = 0) ->
    $('#current-total').find('.sub-total').html(price)

  setShipping: ->
    address = $('#order_address_id').find('option[selected]')
    if address.length is 1
      rate = $('#order_address_attributes_country_id').find('option[selected]').data('shipping-rate')
      shipping = $('#current-total').find('.shipping-rate')
      if shipping and rate
        shipping.html(rate)
        shipping.attr('data-shipping-rate', rate)

  setTotal: (price = 0) ->
    $('#current-total').find('.total').html(price)
