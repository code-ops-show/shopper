class CartsController < OrdersController
  before_filter :check_items, only: [:edit]
  
  def show
  end

  def edit
    @cart = Order.where(id: params[:id]).includes(items: [:product]).first
    @cart.address = @cart.address || current_or_guest_user.default_address || Address.new
  end

  def update
    @cart = Order.find(params[:id])
    if @cart.update_attributes(params[:order])
      setup_guest(@cart) if params[:order][:guest_email]
    else
      render_box_error_for(@cart)
    end
  end

private
  def check_items
    if current_order.items_count.eql?(0)
      respond_to do |format|
        format.js { render js: "window.location = '/'" }
        format.html { 
          flash[:error] = "You should add product to cart before purchase."
          redirect_to root_path
        }
      end
    end
  end

  def setup_guest(cart)
    reset_session
    session[:guest_email] = cart.reload.address.email
  end
end