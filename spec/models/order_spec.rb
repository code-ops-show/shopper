require 'spec_helper'

describe Order do
  it { should have_many :items }
  it { should have_many(:products).through(:items) }

  describe "order" do
    before :all do
      @order = Order.make!(token: '12321kjljo')
    end

    let(:item)   { Item.make! }
    let(:order)   { item.order }

    describe 'state_machine' do
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

    describe 'total_price' do
      it "should total price" do
        order.total.should eq(100)
      end
    end

    describe 'self.cart_by token' do
      it "should update create_at if cart present " do
        Order.cart_by('12321kjljo').should_not be_nil
      end

      it "should equal cart " do
        Order.cart_by('12321kjljo').should eq @order
      end
    end
  end
end