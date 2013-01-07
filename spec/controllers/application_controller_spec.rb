require 'spec_helper'

describe ApplicationController do
  let(:user) { User.make! }

  before :each do
    @controller = ApplicationController.new
  end

  describe "current_or_guest_user" do
    it "should return current user if user existed" do
      controller.stub(:current_user).and_return(user)
      @controller.send(:current_or_guest_user).should eq user
    end

    it "should return guest user if user doesn't exist" do
      @controller.send(:current_or_guest_user)
    end
  end
end