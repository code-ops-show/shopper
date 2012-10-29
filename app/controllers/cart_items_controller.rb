class CartItemsController < ApplicationController
  def create
    current_cart.cart_items.create!(params[:cart_item])
    flash[:notice] = "Product added to cart"
    redirect_to :back
  end
end