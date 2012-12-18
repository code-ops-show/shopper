class CartsController < OrdersController
  def edit
    @cart = Order.where(id: params[:id]).includes(items: [:product]).first
    @cart.address = (current_user and current_user.select_address_for(params[:order])) || Address.new

    session[:shipping_rate] = @cart.address.new_record? ? nil : @cart.address.country.shipping_rate.rate
    @total = current_order.total + (session[:shipping_rate] || 0)
  end

  def update
    @cart = Order.find(params[:id])
    if @cart.update_attributes(params[:order])
      @cart.purchase if params[:order][:address_id]
    else 
      render_box_error_for(@cart)
    end
  end
end