class CartsController < OrdersController
  def edit
    @cart = Order.where(id: params[:id]).includes(items: [:product]).first
    @cart.address = current_or_guest_user.select_address_for(params[:order]) || Address.new
  end

  def update
    @cart = Order.find(params[:id])
    if @cart.update_attributes(params[:order])
      @cart.purchase if params[:order][:address_id] or (current_or_guest_user and params[:order][:address_attributes])
      session.delete(:guest_user_id)
      redirect_to root_path
    else 
      render_box_error_for(@cart)
    end
  end
end