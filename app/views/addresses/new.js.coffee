$('body').append("<div id='modal' class='modal hide fade in address'></div>") if $('#modal').length is 0
$('#modal').html("<%= j render 'addresses/form_modal', address: @address %>")
$('#modal').modal('show')