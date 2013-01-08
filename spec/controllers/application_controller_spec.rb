require 'spec_helper'

describe ApplicationController do
  let(:user) { User.make! }
  let(:guest) { Guest.make! }

  describe "current_or_guest_user" do
    it "should return current user if user existed" do
      controller.stub(:current_user).and_return(user)
      controller.send(:current_or_guest_user).should eq user
    end

    it "should return guest user if user doesn't exist" do
      session[:guest_user_id] = guest.id
      controller.stub(:current_user).and_return(nil)
      controller.send(:current_or_guest_user).should eq guest
    end
  end
end