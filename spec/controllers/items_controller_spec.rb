require 'spec_helper'

describe ItemsController do

  let(:item)        { Item.make! }
  let(:product)     { item.product }
  let!(:order)      { item.order }

  before :all do 
    @item = { quantity: 1 }
    @item_fail = { product_id: product.id, quantity: 10000 }
  end

  describe "POST 'create'" do
    it "return http success" do
      post :create, item: @item, product_id: product.id, format: :js
      response.should be_succes
    end

    it "return http success" do
      @item = { quantity: -1 }
      post :create, item: @item, product_id: product.id, format: :js
      response.body.should include "Quantity must be greater than 0"
    end

     it "creates a new item" do
      expect{
        post :create, item: @item, product_id: product.id, format: :js
      }.to change(Item, :count).by(1)
    end
  end

  describe "PUT 'update'" do

    let(:item_attr) { { quantity: 4 } }

    before :all do
      @item = order.items.make!
    end

    it "return http success" do
      controller.stub!(:current_order).and_return(order)
      put :update, id: @item.id, item: item_attr, format: :js
      response.should be_succes
    end

    it "should located the requested @address " do
      controller.stub!(:current_order).and_return(order)
      put :update, id: @item.id, item: item_attr, format: :js
      item.reload
      assigns(:item).should eq(@item) 
    end

    it "should changes @item's attributes" do
      controller.stub!(:current_order).and_return(order)
      put :update, id: @item.id, item: item_attr, format: :js
      @item.reload
      @item.quantity.should eq(4)
    end
  end
end