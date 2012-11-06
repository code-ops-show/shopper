require 'spec_helper'

describe CartItemsController do

  let(:product) { Product.make! }
  let(:cart)    { Cart.make! }

  before :all do 
    @cart_item = { product_id: product.id, quantity: 1 }
  end

  describe "POST 'create'" do
    
    before :each do
      request.env["HTTP_REFERER"] = "where_i_came_from"
    end

    it "should assign the course to the view" do
      post :create, product_id: product.id, cart_item: @cart_item
      flash[:notice].should_not be_nil
    end

    it "redirects back to the referring page" do
      post :create, product_id: product.id, cart_item: @cart_item
      response.should redirect_to "where_i_came_from"
    end
  end
end