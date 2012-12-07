class OrdersController < ApplicationController
  def index
  end

  def edit
    @order = Order.find(params[:id])
    @order.address = 
      if params[:order] and params[:order][:address_id].present?
        Address.find(params[:order][:address_id])
      elsif not params[:order] and current_user.default_address.present?
        current_user.default_address
      else
        Address.new
      end
  end

  def update
    @order = Order.find(params[:id])
    if @order.update_attributes!(params[:order])
      @order.purchase
      redirect_to root_path
    else
      redirect_to :index
    end
  end
end