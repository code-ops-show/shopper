require 'spec_helper'

describe ItemsController do

  let(:product)     { Product.make! }
  let!(:order)      { Order.make! }

  before :all do 
    @item = { product_id: product.id, quantity: 1 }
  end

  describe "POST 'create'" do
    before :each do
      request.env["HTTP_REFERER"] = "where_i_came_from"
    end

    it "should add new item to order" do
      post :create, item: @item
      response.should redirect_to "where_i_came_from"
    end

     it "creates a new contact" do
      expect{
        post :create, item: @item
      }.to change(Item,:count).by(1)
    end

    it "should redirects back to the referring page" do
      post :create, product_id: product.id, item: @item
      response.should redirect_to "where_i_came_from"
    end
  end

  describe "PUT 'update'" do

    let(:item_attr) { { quantity: 4 } }

    before :all do
      @item = order.items.make!
    end

    it "should located the requested @address " do
      put :update, id: @item.id, item: item_attr, format: :js
      @item.reload
      assigns(:item).should eq(@item) 
    end

    it "should changes @item's attributes" do
      put :update, id: @item.id, item: item_attr, format: :js
      @item.reload
      @item.quantity.should eq(4)
    end
  end
end