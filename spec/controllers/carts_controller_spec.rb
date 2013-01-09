require 'spec_helper'

describe CartsController do

  let!(:item)               { Item.make! }
  let!(:order)              { item.order }
  let!(:address)            { order.address }
  let!(:user)               { address.user }
  let(:address_attr_fail)   { { street_address: 'street-1', city: 'city-1', 
                            state: 'state-1', zip: 12223,
                            country_id: 1, user_id: user.id } }

  before :each do
    controller.stub(:current_user).and_return(user)
    controller.stub(:current_order).and_return(order)
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

    it "should render to home page if javascript format" do
      controller.stub(:current_order).and_return(Order.make!(items_count: 0))
      get :edit, id: order.id, format: :js
      response.body.should include "window.location = '/'"
    end

    it "should render to flash error if html format" do
      controller.stub(:current_order).and_return(Order.make!(items_count: 0))
      get :edit, id: order.id
      flash[:error].should include "You should add product to cart before purchase."
      response.should redirect_to root_path
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
      put :update, id: order.id, order: { address_id: address.id }, format: :js
      assigns[:cart].should_not be_nil
    end

    it "should assign order" do
      put :update, id: order.id, order: { address_id: address.id }, format: :js
      assigns[:cart].should eq order
    end

    it "should update attribute and keep guest email session" do
      put :update, id: order.id, order: { address_id: address.id, guest_email: user.email }, format: :js
      session[:guest_email].should eq user.email 
    end

    it "should render error box" do
      Order.any_instance.stub(:update_attributes).and_return(false)
      put :update, id: order.id, order: { address_id: order.address.id, guest_email: '' }, format: :js
      response.body.should eq "{\"noty\":{}}"
    end
  end
end