require 'spec_helper'

describe ApplicationController do
  let(:user) { User.make! }

  describe "current_or_guest_user" do
    it "should return current user if user existed" do
    end

    it "should return guest user if user doesn't exist" do
      
    end
  end
end