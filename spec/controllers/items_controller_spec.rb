require 'spec_helper'

describe ItemsController do

  let(:item)        { Item.make! }
  let(:product)     { item.product }
  let!(:order)      { item.order }

  before :all do 
    @item = { quantity: 1 }
  end

  describe "POST 'create'" do
    it "should return http success" do
      post :create, item: @item, product_id: product.id, format: :js
      response.should be_success
    end

    it "should error qountity must be greater than 0" do
      @item = { quantity: -1 }
      post :create, item: @item, product_id: product.id, format: :js
      response.body.should include "Quantity must be greater than 0"
    end

    it "should creates a new item" do
      controller.stub(:current_product).and_return(false)
      post :create, item: @item, product_id: product.id, format: :js
      response.body.should include "Product is not available or out of stock."
    end

    it "should" do
      post :create, item: @item, product_id: product.id, format: :js

    end
  end

  describe "PUT 'update'" do

    let(:item_attr) { { quantity: 4 } }
    let(:item_fail) { { quantity: 10000 } }

    before :all do
      @item = order.items.make!
    end

    before :each do
      controller.stub!(:current_order).and_return(order)
    end

    it "return http success" do
      put :update, id: @item.id, item: item_attr, format: :js
      response.should be_success
    end

    it "should located the requested @address " do
      put :update, id: @item.id, item: item_attr, format: :js
      item.reload
      assigns(:item).should eq(@item) 
    end

    it "should changes @item's attributes" do
      put :update, id: @item.id, item: item_attr, format: :js
      @item.reload
      @item.quantity.should eq(4)
    end

    it "should render error box" do
      put :update, id: @item.id, item: item_fail, format: :js
      response.body.should include "Number is over product quantity"
    end
  end

  describe 'DELETE destroy' do
    before :each do
      controller.stub!(:current_order).and_return(order)
    end
    
    it "return http success" do
      delete :destroy, id: item.id, format: :js
      response.should be_success
    end

    it "should deletes the address" do
      expect{
        delete :destroy, id: item.id, format: :js
      }.to change(Item,:count).by(-1)
    end
  end
end