$(document).ready ->
  $('#search-bar').find('form.sorting').on 'change', (e) ->
    e.preventDefault()
    $(@).submit()
    