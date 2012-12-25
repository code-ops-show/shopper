class GuestsController < ApplicationController
  def new

  end

  def create
    sign_in current_or_guest_user
    redirect_to edit_cart_path(current_order)
  end

  def update
    @guest = Guest.find(params[:id])

    params[:guest][:name] = @guest.email.split('@')[0].gsub(/[._-]/, " ").humanize
    params[:guest][:type] = "Member"

    if @guest.update_attributes(params[:guest])
      member = Member.find(params[:id])
      sign_in member
      redirect_to root_path
    else
      @guest.errors.each { |name, msg| flash[:error] = "#{name} #{msg}".humanize }
      redirect_to :thankful
    end
  end

  def thankful
    redirect_to user_orders_path(current_user) if current_user and current_user.member?

    @guest = Guest.find_by_email(session[:guest_email])
    unless @guest
      session.delete(:guest_email)
      redirect_to root_path
    end
  end
end