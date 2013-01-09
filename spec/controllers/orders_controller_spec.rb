require 'spec_helper'

describe OrdersController do

  let(:order)       { Order.make! }
  let!(:address)    { order.address }
  let(:user)        { address.user }
  let(:guest)       { Guest.make! }

  before :each do
    controller.stub(:current_user).and_return(user)
  end

  describe "GET 'show" do
    it "should return js success" do
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

    it "should return http success" do
      get :show, id: order.id
      response.should be_success
    end

    it "should assign guest" do
      session[:guest_email] = guest.email
      order.update_attributes(state: 'purchased')
      get :show, id: order.id, status: 'purchased'
      assigns[:guest].should_not be_nil
    end

    it "should delete session guest email" do
      session[:guest_email] = user.email
      order.update_attributes(state: 'purchased')
      get :show, id: order.id, status: 'purchased'
      assigns[:guest].should be_nil
      session[:guest_email].should be_nil
    end

    it "should return pdf success" do
      get :show, id: order.id, format: :pdf
      response.should be_success
    end

    it "should redirec to root path when don't have order" do
      get :show, id: 200
      response.should redirect_to root_path
    end

    it "should flash error when don't have order" do
      get :show, id: 200
      flash[:error].should eq 'Order is Unavailable.'
    end
  end

  describe "GET 'index'" do

    before :each do
      controller.stub(:current_user).and_return(user)
    end

    it "should return http success" do
      get :index
      response.should be_success
    end

    it "should assign order" do
      get :index
      assigns[:orders].first.should eq user.orders.first
    end
  end
end