class AddressesController < ApplicationController
  def new
    if current_user
      @address = Address.new
    else
      redirect_to new_user_session_path
    end
  end

  def create
    @address = Address.new(params[:address])
    if @address.save
      current_order.update_attributes(address_id: @address.id )
      current_order.purchase
      redirect_to root_path
      flash[:success] = "Purchase complate"
    else
      render :new
      flash[:error] = "Fail"
    end
  end
end