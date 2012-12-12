module ApplicationHelper
  def render_menu_for text, path, regxp = nil
    active = request.path == path ? 'active' : ''
    active = request.path.match(regxp) ? 'active' : '' if regxp

    content_tag :li, class: active do
      link_to text, path
    end
  end

  def render_cart_menu
    active = request.path == edit_order_path(current_order.id) ? 'active' : ''
    size = current_order.items.sum(&:quantity)
    
    content_tag :li, class: "cart #{active}" do
      link_to (current_user and active.eql?('active')) ? edit_order_path(current_order.id) : orders_path, remote: true do
        "<i class=\"icon-shopping-cart icon-white\"></i> Cart (#{size})".html_safe
      end
    end
  end

  def render_user_menu
    active = 'active' if request.path.match(/users/)

    content_tag :li, class: "dropdown #{active}" do
      if current_user
        link = link_to '#', class: 'dropdown-toggle', data: { toggle: 'dropdown' } do
          concat "#{current_user} <b class=\"caret\"></b>".html_safe
        end
        menu = content_tag :ul, class: "dropdown-menu" do
          concat render_menu_for("Profile", edit_user_registration_path)
          concat render_menu_for("Orders History", user_orders_path(current_user))
          concat content_tag :li, (link_to "Log out", destroy_user_session_path, method: :delete)
        end

        link.concat menu
      else
        link = link_to '#', class: 'dropdown-toggle', data: { toggle: 'dropdown' } do
          concat "Login / Register <b class=\"caret\"></b>".html_safe
        end
        menu = content_tag :ul, class: "dropdown-menu" do
          concat render_menu_for("Login", new_user_session_path)
          concat render_menu_for("Register", new_user_registration_path)
        end

        link.concat menu
      end
    end
  end

  def product_added_for product_id
    cart_order ||= current_order.product_ids.include?(product_id)
  end
end
