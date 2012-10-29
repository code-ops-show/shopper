class HomeController < ApplicationController
  def index
    @products = Product.last_four_products
    @cart = current_cart
  end
end