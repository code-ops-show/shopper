class ProductsController < ApplicationController
  before_filter :set_price_range, only: [:index]

  def index
    @products = params[:category_id].present? ? Product.by_category(params[:category_id]) : Product
    @products = (session[:min].present? and session[:max].present?) ? @products.by_price_range(session[:min], session[:max]) : @products.all
  end

  def show
    @product = Product.find(params[:id])

    add_breadcrumb "Store", products_path
    add_breadcrumb @product.category.name, category_products_path(@product.category)
    add_breadcrumb @product.name, product_path(@product)
  end

private
  def set_price_range
    session[:min] = params[:min] if params[:min]
    session[:max] = params[:max] if params[:max]
  end
end