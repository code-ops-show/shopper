require 'spec_helper'

describe ItemsController do

  let(:product)     { Product.make! }
  let!(:order)      { Order.make! }

  before :all do 
    @item = { product_id: product.id, quantity: 1 }
  end

  describe "POST 'create'" do
     it "creates a new item" do
      expect{
        post :create, item: @item, format: :js
      }.to change(Item, :count).by(1)
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