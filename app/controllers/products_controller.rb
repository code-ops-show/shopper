class ProductsController < ApplicationController  
  def index
    @products = params[:category_id].present? ? Product.by_category(params[:category_id]) : Product.all
  end

  def show
    @product = Product.find(params[:id])

    add_breadcrumb "Store", products_path
    add_breadcrumb @product.name, product_path(@product)
  end
end