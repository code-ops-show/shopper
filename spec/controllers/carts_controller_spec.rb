require 'spec_helper'

describe CartsController do

  let(:order)       { Order.make! }
  let!(:address)    { order.address }
  let(:user)        { address.user }

  before :each do
    controller.stub(:current_user).and_return(user)
  end

  describe "GET 'edit'" do
    it "should return http success" do
      get :edit, id: order.id, format: :js
      response.should be_success
    end

    it "should assign order" do
      get :edit, id: order.id, format: :js
      assigns[:cart].should_not be_nil
    end

    it "should assign order" do
      get :edit, id: order.id, format: :js
      assigns[:cart].should eq order
    end

    it "should assign order address" do
      get :edit, id: order.id, format: :js
      assigns[:cart].address.should_not be_nil
    end

    it "should assign order address" do
      get :edit, id: order.id, format: :js
      assigns[:cart].address.should eq order.address
    end

    it "should assign order address with default address should not nil" do
      sign_in user
      get :edit, id: order.id, format: :js
      assigns[:cart].address.should_not be_nil
    end

    it "should assign order address with default address" do
      sign_in user
      get :edit, id: order.id, format: :js
      assigns[:cart].address.should eq address
    end

    it "should assign order address with find by param should not nil" do
      get :edit, id: order.id, order: order, format: :js
      assigns[:cart].address.should_not be_nil
    end

     it "should assign order address with find by param" do
      get :edit, id: order.id, order: order, format: :js
      assigns[:cart].address.should eq address
    end
  end

  describe "PUT 'update'" do
    it "should assign order" do
      put :update, id: order.id, order: { address_id: address.id }
      assigns[:cart].should_not be_nil
    end

    it "should assign order" do
      put :update, id: order.id, order: { address_id: address.id }
      assigns[:cart].should eq order
    end

    it "should redirects back to root path" do
      put :update, id: order.id, order: { address_id: address.id }
      response.should redirect_to root_path
    end
  end
end