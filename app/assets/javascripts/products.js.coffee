$(document).ready ->
  togglePrice = (element, icon) ->
    if element.hasClass('collapse') 
      if element.hasClass('in')
        icon.removeClass('icon-chevron-up').addClass('icon-chevron-down')
        element.collapse('hide')
      else 
        icon.removeClass('icon-chevron-down').addClass('icon-chevron-up')
        element.collapse('show')

  $('.price-rate').on 'click', 'a.price-toggle', (e) ->
    e.preventDefault()
    icon = $(@).find('i')
    element = $('.price-rate').find('.price')
    togglePrice(element, icon)