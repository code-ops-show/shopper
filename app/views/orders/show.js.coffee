$('body').append("<div id=\"modal\" class='modal hide fade in order'></div>") if $('#modal').length is 0
$('#modal').html("<%= j render 'orders/show', order: @order %>")
$('#modal').modal('show')