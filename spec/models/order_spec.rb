require 'spec_helper'

describe Order do
  it { should have_many :items }
  it { should have_many(:products).through(:items) }

  describe "order" do
    before :all do
      @order = Order.make!
    end

    it "should be an initial state" do
      @order.cart?.should be_true
    end

    it "should change to :cart on :purchased" do
      @order.purchase!
      @order.purchased?.should be_true
    end

    it "should change to :purchased on :canceled" do
      @order.cancel!
      @order.canceled?.should be_true
    end

    it "should change to :canceled on :purchased" do
      @order.resume!
      @order.purchased?.should be_true
    end
    
    it "should change to :purchased on :shipped" do
      @order.ship!
      @order.shipped?.should be_true
    end
  end
end