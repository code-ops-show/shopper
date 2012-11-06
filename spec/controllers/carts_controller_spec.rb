require 'spec_helper'

describe CartsController do

  let(:cart) { Cart.make!(token: cookies[:token]) }

  describe "GET 'index'" do
    it "return http success" do
      get :index
      response.should be_success
    end

    it "should assign the all current cart to the view" do
      get :index
      assigns[:cart].should_not be_nil
    end

    it "should assign the all current cart to the view" do
      request.cookies['token'] = 'abcd12345'
      cart = Cart.make!(token: cookies[:token])

      get :index
      assigns[:cart].should eq cart
    end
  end
end