require 'spec_helper'

describe ApplicationController do
  let(:user)  { User.make! }
  let(:guest) { Guest.make! }
  let(:order) { Order.make! }

  controller do
    def after_sign_in_path_for(resource)
        super resource
    end
  end

  describe "current_or_guest_user" do
    it "should return current user if user existed" do
      controller.stub(:current_user).and_return(user)
      controller.send(:current_or_guest_user).should eq user
    end

    it "should return guest user if user doesn't exist with session" do
      session[:guest_user_id] = guest.id
      controller.stub(:current_user).and_return(nil)
      controller.send(:current_or_guest_user).should eq guest
    end

    it "should return guest user if user doesn't exist with out session" do
      session[:guest_user_id] = nil
      controller.stub(:current_user).and_return(nil)
      controller.send(:current_or_guest_user).id.should eq session[:guest_user_id]
    end
  end

  describe "After sigin-in" do
    it "redirects to edit cart path" do
      request.env["HTTP_REFERER"] = new_guest_path
      controller.stub(:current_order).and_return(order)
      controller.after_sign_in_path_for(new_guest_path).should == edit_cart_path(order)
    end

    it "redirects to root path" do
      request.env["HTTP_REFERER"] = new_user_session_path
      controller.after_sign_in_path_for(new_guest_path).should == root_path
    end
  end
end