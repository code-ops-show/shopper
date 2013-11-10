require 'spec_helper'

describe Guest do
  let!(:guest)   { Guest.make! }
  let!(:address) { guest.addresses.make! }

  describe "move_to user" do
    it "should move address to exit user" do
      member = Member.make!
      member.addresses.make!
      guest.move_to(member)
      member.addresses.size.should eq 2
    end
  end

  describe "set_default_to address" do
    it "should set set default to address" do
      new_address = guest.addresses.make!(default: false)
      new_address.default.should_not be_true
      guest.set_default_to(new_address)
      new_address.default.should be_true
    end
  end

  describe "to_member" do
    it "should change guest to member" do
      guest.to_member
      guest.type.should eq "Member"
    end
  end
end