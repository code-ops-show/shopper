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
end