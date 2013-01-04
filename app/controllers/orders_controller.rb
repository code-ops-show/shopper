class OrdersController < ApplicationController
  def index
    @orders = current_user.orders.order('created_at DESC')
  end

  def show
    @order = Order.where(id: params[:id]).includes(items: [:product]).first
    get_guest if @order.state == params[:status]
  end

private
  def get_guest
    @guest = Guest.find_by_email(session[:guest_email])
    session.delete(:guest_email) unless @guest
  end
end