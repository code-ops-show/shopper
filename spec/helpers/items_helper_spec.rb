# encoding: UTF-8
require 'spec_helper'

describe ItemsHelper do

  let(:item) { Item.make! }
  let(:product) { item.product }

  describe 'full_price' do
    it "should return item's unit price x item's quantity" do
      helper.full_price(item).should eq '฿100.00'
    end

    it "should return item not be nil" do
      helper.full_price(item).should_not be_nil
    end

    it "should return correctly in currency " do
      helper.full_price(item).should_not eq(100)
    end
  end
end