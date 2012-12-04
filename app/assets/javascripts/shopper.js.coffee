$(document).ready ->
  $('#flash').on 'click', 'a.close', (e) ->
    e.preventDefault()
    $('#flash').remove()