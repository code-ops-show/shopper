require 'spec_helper'

describe CartItem do
  it { should belong_to :product }
  it { should belong_to :cart }

  describe "Model setup and utilities" do
    let(:product) { Product.make! }
    let(:cart)    { Cart.make! }

    before :all do 
      cart.products.push product
      @cart_item = CartItem.first
      @cart_item.update_attributes(quantity: 10)
    end

    it "should return unit price" do
      @cart_item.unit_price.should eq(product.price)
    end

    it "should return full price" do
      @cart_item.full_price.should eq(1000)
    end
  end
end