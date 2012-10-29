class ApplicationController < ActionController::Base
  protect_from_forgery

 private
  def current_cart
    @current_cart ||= Cart.first || Cart.create!
  end
end
