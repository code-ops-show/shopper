$("#product_<%= @item.product.id %>").replaceWith("<%= j render @item.product %>")
$("#product_<%= @item.product.id %>").find('.caption').effect('highlight', {}, 2000)
$("#item_<%= @item.id %>").fadeOut 'slow', (-> $(@).remove())

Cart.update(<%= current_order.items_count %>)