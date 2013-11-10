require 'spec_helper'

describe ProductsHelper do
  let(:item)        { Item.make! }
  let(:product)     { item.product }
  let(:order)       { item.order }

  before :each do
    view.stub!(:current_order).and_return(order)
  end

  describe 'product_added_for' do
    it "should return true" do
      helper.product_added_for(product.id).should be_true
    end

    it "should return false" do
      helper.product_added_for(100).should be_false
    end
  end

  describe 'add_cart_for' do
    it "should return update" do
      helper.add_cart_for(product).should eq order.items.first
    end

    it "should return create" do
      product_new = Product.make!
      helper.add_cart_for(product_new).should include product_new
    end
  end
end