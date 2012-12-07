class ProductsController < ApplicationController  
  def index
    @products = 
      if params[:category_id].present?
        Product.joins(:category).where(categories: { slug: params[:category_id] })
      else
        Product.all
      end
  end

  def show
    @product = Product.find(params[:id])

    add_breadcrumb "Product", products_path
    add_breadcrumb @product.name, product_path(@product)
  end
end