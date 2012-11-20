class CartItemsController < ApplicationController
  def create
    if have_cart_item.blank?
      current_cart.cart_items.create!(params[:cart_item])
      flash[:notice] = "Product added to cart"
      redirect_to :back
    else
      update_cart
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    current_cart = @cart_item.cart
    @cart_item.update_attributes(params[:cart_item])
  end

  def update_cart
    cart = have_cart_item
    puts cart
    cart.first.update_attributes(quantity: update_quantity) ? flash[:notice] = "Product added to cart": flash[:notice] = "Product added to cart"
    redirect_to :back
  end

private
  def have_cart_item
    current_cart.cart_items.where(product_id: params[:cart_item][:product_id])
  end

  def update_quantity
    current_cart.cart_items.where(product_id: params[:cart_item][:product_id]).first.quantity + params[:cart_item][:quantity].to_i
  end
end