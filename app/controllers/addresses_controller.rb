class AddressesController < ApplicationController
  def show
    @address = Address.find(params[:id])
  end

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(params[:address])
    
    unless @address.save
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    
    unless @address.update_attributes(params[:address])
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
  end
end