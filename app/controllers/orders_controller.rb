class OrdersController < ApplicationController
  def show
    @order = Order.where(id: params[:id]).includes(items: [:product]).first
  end

  def edit
    @order = Order.where(id: params[:id]).includes(items: [:product]).first
    @order.address = current_user.select_address_for(params[:order]) || Address.new
  end

  def update
    @order = Order.find(params[:id])
    @order.update_attributes!(params[:order])
    @order.purchase
    redirect_to root_path
  end
end