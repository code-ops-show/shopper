class OrdersController < ApplicationController
  def index
    @order ||= current_order
  end

  def edit
    if current_user
      @order = Order.find(params[:id])
    else
      redirect_to new_user_session_path
    end
  end

  def update
    @order = Order.find(params[:id])
    @order.address.push params[:order][:address]

    if @order.save!
      redirect_to root_path
      flash[:success] = "Purchase complate"
    else
      redirec_to :edit
      flash[:success] = "Fail"
    end
  end
end