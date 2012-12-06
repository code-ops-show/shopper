class OrdersController < ApplicationController
  def index
  end

  def edit
    @order = Order.find(params[:id])
    @order.address = ( params[:order] and params[:order][:address_id].present? ) ? Address.find(params[:order][:address_id]) : Address.new
  end

  def update
    @order = Order.find(params[:id])
    if @order.update_attributes!(params[:order])
      @order.purchase
      redirect_to root_path
    else
      render :index
    end
  end
end