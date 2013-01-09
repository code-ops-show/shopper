require 'spec_helper'

describe CartsHelper do

  let!(:item)               { Item.make! }
  let!(:order)              { item.order }
  let!(:address)            { order.address }
  let!(:user)               { address.user }

  describe 'check_out' do
    it "should go to edit cart path" do
      helper.stub!(:current_user).and_return(user)
      helper.stub!(:current_order).and_return(order)
      helper.check_out.should eq edit_cart_path(order)
    end

    it "should go to new guest path" do
      helper.stub!(:current_user).and_return(false)
      helper.check_out.should eq new_guest_path
    end
  end
end