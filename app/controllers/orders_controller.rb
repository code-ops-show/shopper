class OrdersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @order = Order.where(id: params[:id]).includes(items: [:product]).first
  end
end