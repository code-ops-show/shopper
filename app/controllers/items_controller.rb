class ItemsController < ApplicationController
  def create
    if item.blank?
      current_order.items.create!(params[:item])
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
    if item.product.quantity >= update_quantity
      item.update_attributes(quantity: update_quantity)
    else
      render json: [{error: "Product quantity not enough for add to cart"}], status: :unprocessable_entity
    end
  end

  def item
    current_order.items.where(product_id: params[:item][:product_id]).first
  end

  def update_quantity
    item.quantity + params[:item][:quantity].to_i
  end
end