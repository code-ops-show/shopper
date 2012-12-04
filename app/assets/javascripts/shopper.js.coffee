$(document).ready ->
  $('body').ajaxError (e, xhr, settings, exception) ->
    message = switch xhr.status
      when 422 then JSON.parse(xhr.responseText)[0]
      when 500 then "#{xhr.statusText}."
      else "Fail, please check action again or contact admin."

    message = if message.error? then message.error else message

    noty
      text: message
      type: 'error'
      layout: 'topRight'
      timeout: 4000

  $('#flash').on 'click', 'a.close', (e) ->
    e.preventDefault()
    $('#flash').remove()