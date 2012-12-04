module ApplicationHelper
  def render_cart_menu
    order = Order.where(token: cookies[:token], state: 'cart').first
    
    if current_user and request.path == edit_order_path(order)
      link_to edit_order_path(order) do
        "<i class=\"icon-shopping-cart icon-white\"></i> Cart".html_safe
      end
    else
      link_to orders_path, remote: true do
        "<i class=\"icon-shopping-cart icon-white\"></i> Cart".html_safe
      end
    end
  end
end
