$(document).ready ->
  $('body').ajaxError (e, xhr, settings, exception) ->
    response = switch xhr.status
      when 422 then JSON.parse(xhr.responseText)
      when 500 then "#{xhr.statusText}."
      else "Fail, please check action again or contact admin."

    if response.noty?
      errors = ""
      errors += "#{v[0]}\n" for k, v of response.noty 
      noty
        text: errors
        type: 'error'
        layout: 'topRight'
        timeout: 4000
    else if response.errors?
      for k, v of response.errors
        element = $("##{response.model}_#{k}")
        if element.length > 0
          element.parents('.control-group').addClass('error')
          element.attr('placeholder', v)
          # element.parents('.controls').append("<span class='help-block'>#{v}</span>") if element.parents('.controls').find('.help-block').length is 0

  $('#flash').on 'click', 'a.close', (e) ->
    e.preventDefault()
    $('#flash').remove()