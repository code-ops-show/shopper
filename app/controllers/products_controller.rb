class ProductsController < ApplicationController
  before_filter :set_filter, only: [:index]

  def index
    @products = Product.by_category(params[:category_id])
                       .text_search(params[:query])
                       .by_price_range(session[:min], session[:max])
                       .sort_by(session[:sort_by])
  end

  def show
    @product = Product.find(params[:id])

    add_breadcrumb "Store", products_path
    add_breadcrumb @product.category.name, category_products_path(@product.category)
    add_breadcrumb @product.name, product_path(@product)
  end

private
  def set_filter
    session[:min] = params[:min] if params[:min]
    session[:max] = params[:max] if params[:max]
    session[:sort_by] = params[:sort_by] || session[:sort_by] || 1
  end
end