class UsersController < ApplicationController
  def update
    @guest = Guest.find(params[:id])
    @guest.to_member

    if @guest.update_attributes(params[:guest])
      member = Member.find(params[:id])
      sign_in member
      redirect_to root_path, notice: "Create account successfully! :)"
    else
      @guest.errors.each { |name, msg| flash[:error] = "#{name} #{msg}".humanize }
      redirect_to :back
    end
  end
end