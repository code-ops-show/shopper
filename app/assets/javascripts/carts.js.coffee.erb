$(document).ready ->
  Cart.setup()
window.Cart =
  setup: ->
    @eventCart()
    @eventShipping()
    @eventPurchase()
    Cart.setShippingAddress() if $('body.carts').length is 1

  update: (quantity = 0) ->
    cart = $('.navbar').find('.cart a')
    cart.stop(true, true).effect('pulsate', { times: 3 })
    cart.html("<i class=\"icon-shopping-cart icon-white\"></i> Cart (#{quantity})")

  setShippingAddress: ->
    checked = $('#shipping input[name="order[address_id]"]:checked')

    if checked.length is 1 and not $('#order_address_id').val() > 0
      setTimeout (-> checked.click()), 10
    else if checked.length is 0
      setTimeout (->
        $('#order_address_id').val("")
        $('#shipping input[name="order[address_id]"]').click()
      ), 10

  eventCart: ->
    timer = null
    $('#view_cart').on 'input', 'input[name*="[quantity]"]', (e) ->
      if timer then clearTimeout(timer)
      timer = setTimeout (=> 
          $.ajax
            url: $(@).parents('form').attr('action')
            data: $(@).parents('form').serialize()
            dataType: 'script'
            type: "POST"
            error: (jqXHR, textStatus, error) =>
              $(@).effect('highlight', {}, 2000)
              $(@).val($(@).data('quantity'))
        ), 600

  eventShipping: ->
    timer = null
    $('#shipping').on 'click', 'input[name="order[address_id]"]', (e) ->
      if timer then clearTimeout(timer)
      timer = setTimeout (=> 
          $.ajax
            url: $(@).parents('form').attr('action')
            data: $(@).parents('form').serialize()
            dataType: 'script'
            type: "POST"
        ), 600

  eventPurchase: ->
    timer = null
    $('#current-total').on 'click', 'button.purchase', (e) ->
      e.preventDefault()
      if not $('#purchase').find('#order_address_id').val()
        noty 
          text: "Please choose shipping address."
          type: 'error'
          layout: 'topRight'
          timeout: 4000
      else if $('input[name*="order[items_attributes]"]').length is 0
        noty 
          text: "You should add product to cart before purchase."
          type: 'error'
          layout: 'topRight'
          timeout: 4000
      else
        $('#purchase').modal('show')
        $('#purchase').on 'shown', -> $(@).find('#order_guest_email').focus()