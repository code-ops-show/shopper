class CartsController < OrdersController
  before_filter :authenticate_user!, only: [:edit, :update]
  before_filter :check_items, only: [:edit]

  def edit
    @cart = Order.where(id: params[:id]).includes(items: [:product]).first
    @cart.address = @cart.address || current_or_guest_user.default_address || Address.new
  end

  def update
    @cart = Order.find(params[:id])
    if @cart.update_attributes(params[:order])

      if params[:order][:state_event]
        reset_session
        sign_in @cart.address.user
      end

      respond_to do |format|
        format.js {
          render action: "update" if params[:order][:state_event]
          render action: "items/update_items" if params[:order][:items_attributes]
          render action: "addresses/update_addresses" if params[:order][:address_id]
        }
        format.html { redirect_to root_path }
      end
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
          flash[:notice] = "You should add product to cart before checkout."
          redirect_to root_path
        }
      end
    end
  end
end