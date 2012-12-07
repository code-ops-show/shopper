$('body').append("<div id=\"modal\" class='modal hide fade in cart'></div>") if $('#modal').length is 0
$('#modal').html("<%= j render 'orders/show', order: @order %>")
$('#modal').modal('show')