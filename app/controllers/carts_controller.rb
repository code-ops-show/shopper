class CartsController < OrdersController
  before_filter :authenticate_user!

  def edit
    @cart = Order.where(id: params[:id]).includes(items: [:product]).first
    @cart.address = @cart.address || current_or_guest_user.default_address || Address.new
  end

  def update
    @cart = Order.find(params[:id])
    if @cart.update_attributes(params[:order])
      respond_to do |format|
        format.js {
          render action: "items/update_items" if params[:order][:items_attributes]
          render action: "addresses/update_addresses" if params[:order][:address_id]
        }
        format.html { redirect_to root_path }
      end
    else 
      render_box_error_for(@cart)
    end
  end
end