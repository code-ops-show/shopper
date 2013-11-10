class AddressesController < ApplicationController
  before_filter :authenticate_user!
  
  def new
    @address = Address.new
  end

  def create
    @address = Address.new(params[:address])
    render_form_error_for @address unless @address.save
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    render_form_error_for @address unless @address.update_attributes(params[:address])
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
  end
end