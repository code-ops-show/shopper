class HomeController < ApplicationController
  def index
    @products = Product.last_four_products
  end
end