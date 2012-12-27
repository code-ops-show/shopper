class OrdersController < ApplicationController
  def index
    @orders = current_user.orders.order('created_at DESC')
  end

  def show
    @order = current_user.orders.where(id: params[:id]).includes(items: [:product]).first

    if @order
      get_guest if params[:status] and @order.state == params[:status]

      respond_to do |format|
        format.html
        format.pdf do
          pdf = OrderPdf.new(@order, view_context)
          send_data pdf.render, filename: "order_#{@order.id}",
                                type: "application/pdf",
                                disposition: "inline"
        end
      end
    else
      redirect_to root_path, flash: { error: "Order is Unavailable." }
    end
  end

private
  def get_guest
    @guest = Guest.find_by_email(session[:guest_email])
    session.delete(:guest_email) unless @guest
  end
end