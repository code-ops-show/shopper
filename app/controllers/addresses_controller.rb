class AddressesController < ApplicationController
  def show
    @address = Address.find(params[:id])
  end

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(params[:address])
    @address.save ? redirect_to(edit_user_registration_path(current_user)) : render(:new)
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    @address.update_attributes(params[:address]) ? render(:show) : render(:edit)
  end

  def destroy
    Address.find(params[:id]).destroy
    redirect_to edit_user_registration_path
  end
end