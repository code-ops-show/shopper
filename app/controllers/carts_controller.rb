class CartsController < OrdersController
  def edit
    @cart = Order.where(id: params[:id]).includes(items: [:product]).first
    @cart.address = current_user.select_address_for(params[:order]) || Address.new
  end

  def update
    @cart = Order.find(params[:id])
    @cart.purchase if @cart.update_attributes!(params[:order])
    redirect_to root_path
  end
end