class AddressesController < ApplicationController
  def show
    @address = Address.find(params[:id])
  end

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(params[:address])
    
    if @address.save
      redirect_to(edit_user_registration_path(current_user))
    else
      render json: @address.erorrs, status: :unprocessable_entity
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    
    if @address.update_attributes(params[:address])
      redirect_to(edit_user_registration_path(current_user))
    else
      render json: @address.erorrs, status: :unprocessable_entity
    end
  end

  def destroy
    Address.find(params[:id]).destroy
    redirect_to edit_user_registration_path
  end
end