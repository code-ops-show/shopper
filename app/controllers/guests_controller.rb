class GuestsController < ApplicationController
  def new

  end

  def create
    sign_in current_or_guest_user
    redirect_to edit_cart_path(current_order)
  end
end