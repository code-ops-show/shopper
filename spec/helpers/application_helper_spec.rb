require 'spec_helper'

describe ApplicationHelper do

  let(:item)        { Item.make! }
  let(:product)     { item.product }
  let(:order)       { item.order }
  let(:address)     { order.address }
  let(:user)        { address.user }

  before :each do
    view.stub!(:current_order).and_return(order)
    view.stub!(:current_user).and_return(user)
  end

  describe 'render_menu_for' do 
    it "should prepend active" do
      path = controller.request.path = edit_user_registration_path
      helper.render_menu_for("test", path).should include "<li class=\"active\"><a href=\"/users/edit\">test</a></li>"
    end
  end

  describe 'render_cart_menu' do
    it "should render link to edit oder path" do
      controller.request.path = edit_order_path(order.id)
      helper.render_cart_menu
    end
  end

  describe 'render_user_menu' do
    context "user login" do      
      it "should render drop-down Profile, Orders History and Log out" do
        helper.render_user_menu.should_not be_nil
      end

      it "should have Profile" do
        helper.render_user_menu.should include "Profile"
      end

      it "should have Orders" do
        helper.render_user_menu.should include "Orders History"
      end

      it "should have Log out" do
        helper.render_user_menu.should include "Log out"
      end
    end

    context "No user login" do
      it "should render login/register" do
        helper.render_user_menu.should_not be_nil
      end

      it "should have login" do
        view.stub(:current_user).and_return(false)
        helper.render_user_menu.should include "<li class=\"\"><a href=\"/users/sign_in\">Login</a></li>"
      end

      it "should have register" do
        view.stub(:current_user).and_return(false)
        helper.render_user_menu.should include "<li class=\"\"><a href=\"/users/sign_up\">Register</a></li></ul></li>"
      end
    end
  end
end