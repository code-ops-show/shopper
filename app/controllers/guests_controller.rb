class GuestsController < ApplicationController
  def new
  end

  def create
    sign_in current_or_guest_user
    redirect_to edit_cart_path(current_order)
  end
  
  def update
    @guest = Guest.find(params[:id])
    @guest.to_member

    if @guest.update_attributes(params[:guest])
      member = Member.find(params[:id])
      sign_in member
      redirect_to root_path, notice: "Welcome! You have created account successfully."
    else
      @guest.errors.each { |name, msg| flash[:error] = "#{name} #{msg}".humanize }
      redirect_to :back
    end
  end
end