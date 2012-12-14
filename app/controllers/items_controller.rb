class ItemsController < ApplicationController
  respond_to :js, :json

  def create
    @product = Product.available.find(params[:product_id])
    @item = @product.items.build(params[:item])
    if @item.order = current_order and @item.save
      respond_with @item
    else
      render_box_error_for @item
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
end