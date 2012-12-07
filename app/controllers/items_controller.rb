class ItemsController < ApplicationController
  def create
    current_item.blank? ? current_order.items.create!(params[:item]) : current_item.update_quantity(params[:item][:quantity])
  end

  def update
    @item = Item.find(params[:id])
    @item.update_attributes(params[:item])
  end

private
  def current_item
    current_order.items.where(product_id: params[:item][:product_id]).first
  end
end