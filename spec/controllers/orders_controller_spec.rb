require 'spec_helper'

describe OrdersController do

  let(:order)       { Order.make! }
  let!(:address)    { order.address }
  let(:user)        { address.user }

  before :each do
    controller.stub(:current_user).and_return(user)
  end

  describe "GET 'show" do
   it "should return http success" do
      get :show, id: order.id, format: :js
      response.should be_success
    end

    it "should assign order not be nil" do
      get :show, id: order.id, format: :js
      assigns[:order].should_not be_nil
    end

    it "should assign order" do
      get :show, id: order.id, format: :js
      assigns[:order].should eq order
    end
  end

  describe "GET 'index'" do
    it "should return http success" do
      get :index
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "should return http success" do
      get :edit, id: order.id, format: :js
      response.should be_success
    end

    it "should assign order" do
      get :edit, id: order.id, format: :js
      assigns[:order].should_not be_nil
    end

    it "should assign order" do
      get :edit, id: order.id, format: :js
      assigns[:order].should eq order
    end

    it "should assign order address" do
      get :edit, id: order.id, format: :js
      assigns[:order].address.should_not be_nil
    end

    it "should assign order address" do
      get :edit, id: order.id, format: :js
      assigns[:order].address.should eq order.address
    end

    it "should assign order address with default address should not nil" do
      sign_in user
      get :edit, id: order.id, format: :js
      assigns[:order].address.should_not be_nil
    end

    it "should assign order address with default address" do
      sign_in user
      get :edit, id: order.id, format: :js
      assigns[:order].address.should eq address
    end

    it "should assign order address with find by param should not nil" do
      get :edit, id: order.id, order: order, format: :js
      assigns[:order].address.should_not be_nil
    end

     it "should assign order address with find by param" do
      get :edit, id: order.id, order: order, format: :js
      assigns[:order].address.should eq address
    end
  end

  describe "PUT 'update'" do
    it "should assign order" do
      put :update, id: order.id, order: { address_id: address.id }
      assigns[:order].should_not be_nil
    end

    it "should assign order" do
      put :update, id: order.id, order: { address_id: address.id }
      assigns[:order].should eq order
    end

    it "should redirects back to root path" do
      put :update, id: order.id, order: { address_id: address.id }
      response.should redirect_to root_path
    end
  end
end