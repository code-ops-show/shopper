class CartsController < OrdersController
  def edit
    @cart = Order.where(id: params[:id]).includes(items: [:product]).first
    @cart.address = @cart.address || (current_or_guest_user and current_or_guest_user.default_address) || Address.new
  end

  def update
    @cart = Order.find(params[:id])
    if @cart.update_attributes(params[:order])
      session.delete(:guest_user_id)
    else 
      render_box_error_for(@cart)
    end

    respond_to do |format|
      format.js {
        render action: "update_items" if params[:order][:items_attributes]
        render action: "update_addresses" if params[:order][:address_id] or params[:order][:addresses_attributes]
      }
    end
  end
end