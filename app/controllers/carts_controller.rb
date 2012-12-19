class CartsController < OrdersController
  def edit
    @cart = Order.where(id: params[:id]).includes(items: [:product]).first
    @cart.address = @cart.address || (current_user and current_user.default_address) || Address.new
  end

  def update
    @cart = Order.find(params[:id])
    render_box_error_for(@cart) unless @cart.update_attributes(params[:order])

    respond_to do |format|
      format.js {
        render action: "update_items" if params[:order][:items_attributes]
        render action: "update_addresses" if params[:order][:address_id] or params[:order][:addresses_attributes]
      }
    end
  end
end