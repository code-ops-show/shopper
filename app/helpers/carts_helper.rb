module CartsHelper
  def check_out
    current_user ? edit_cart_path(current_order) : '/guesses/new'
  end
end