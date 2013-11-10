require 'spec_helper'

describe GuestsController do

  let(:guest)              { Guest.make! }
  let(:address)            { guest.addresses.make! }
  let(:item)               { Item.make! }
  let(:order)              { item.order }

  before :each do
    controller.stub(:current_user).and_return(guest)
    controller.stub(:current_order).and_return(order)
    request.env["HTTP_REFERER"] = "where_i_came_from"
  end

  describe "GET 'new'" do
    it "return http success" do
      get :new
      response.should be_success
    end
  end

  describe "POST 'create'" do
    it "should sign in and redirect to edit path" do
      post :create
      response.should redirect_to edit_cart_path(order)
    end
  end

  describe "PUT 'update'" do
    it "should assign guest" do
      put :update, id: guest.id 
      assigns[:guest].should_not be_nil
    end

    it "should change guest to member" do
      put :update, id: guest.id 
      assigns[:guest].to_member
      assigns[:guest].type.should eq 'Member'
    end

    it "should redirec to root path when guest update attribute success" do
      put :update, id: guest.id, guest: { }
      response.should redirect_to root_path
      flash[:notice].should include "Welcome! You have created account successfully."
    end

    it "should falsh error when guest update attribute fails" do
      put :update, id: guest.id, guest: { email: nil }
      flash[:error].should include "Email can't be blank"
    end

    it "should redirec to back path when guest update attribute fails" do
      put :update, id: guest.id, guest: { email: nil }
      response.should redirect_to "where_i_came_from"
    end
  end
end