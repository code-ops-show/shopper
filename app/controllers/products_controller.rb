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
  end
end