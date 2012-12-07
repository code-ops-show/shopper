require 'spec_helper'

describe OrdersController do

  let(:order)     { Order.make!(token: cookies[:token]) }
  let!(:address)   { order.address }

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
  end

  describe "PUT 'update'" do
    it "should assign order" do
      put :update, id: order.id
      assigns[:order].should_not be_nil
    end

    it "should assign order" do
      put :update, id: order.id
      assigns[:order].should eq order
    end

    it "should redirects back to show" do
      put :update, id: order.id
      response.should redirect_to root_path
    end
  end
end