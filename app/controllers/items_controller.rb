class ItemsController < ApplicationController
  def create
    if cart.blank?
      current_order.items.create!(params[:item])
      flash[:success] = "Product added to cart"
      redirect_to :back
    else
      update_cart
    end
  end

  def update
    @item = Item.find(params[:id])
    @item.update_attributes(params[:item])
  end

private
  def update_cart
    if (cart.quantity + params[:item][:quantity].to_i) <= cart.product.quantity
      cart.update_attributes(quantity: update_quantity)
      flash[:success] = "Product added to cart"
    else
      flash[:notice] = "Product quantity not enough for add to cart"
    end
    redirect_to :back
  end

  def cart
    current_order.items.where(product_id: params[:item][:product_id]).first
  end

  def update_quantity
    cart.quantity + params[:item][:quantity].to_i
  end
end