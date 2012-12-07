class OrdersController < ApplicationController
  def show
    @order = Order.where(id: params[:id]).includes(items: [:product]).first
  end

  def edit
    @order = Order.where(id: params[:id]).includes(items: [:product]).first
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