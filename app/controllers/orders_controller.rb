class OrdersController < ApplicationController
  def index
    @orders = current_user.orders.order('created_at DESC')
  end

  def show
    @order = Order.where(id: params[:id]).includes(items: [:product]).first
  end
end