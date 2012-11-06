class CartsController < ApplicationController
  def index
    @cart ||= current_cart
  end
end