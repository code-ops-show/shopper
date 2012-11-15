class AddressesController < ApplicationController
  def new
    if current_user
      @address = Address.new
    else
      redirect_to new_user_session_path
    end
  end
end