class OrdersController < ApplicationController
  def show
    @order = Order.where(id: params[:id]).includes(items: [:product]).first
  end
end