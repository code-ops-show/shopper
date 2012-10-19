class ProductsController < ApplicationController
  def index
    @product = Product.all
  end
end