class ItemsController < ApplicationController
  respond_to :js, :json

  def create
    if current_product
      @item = current_product.items.build(params[:item])
      (@item.order = current_order and @item.save) ? respond_with(@item) : render_box_error_for(@item)
    else
      render_box_error_for nil, {error: ["Product is not available or out of stock."]}
    end
  end

  def update
    @item = current_order.items.find(params[:id])
    render_box_error_for(@item) unless @item.update_attributes(params[:item])
  end

  def destroy
    @item = current_order.items.find(params[:id])
    render_box_error_for(@item) unless @item.destroy
  end

private
  def current_product
    @product = Product.available.where(id: params[:product_id]).first
  end
end