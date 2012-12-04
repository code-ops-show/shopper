require 'spec_helper'

describe Item do
  it { should belong_to :product }
  it { should belong_to :order }

  describe "Model setup and utilities" do
    let(:product)  { Product.make! }
    let(:order)    { Order.make! }

    before :all do 
      order.products.push product
      @item = Item.first
      @item.update_attributes(quantity: 10)
    end

    it "should return unit price" do
      @item.unit_price.should eq(product.price)
    end

    it "should return full price" do
      @item.full_price.should eq(1000)
    end
  end
end