require 'spec_helper'

describe Order do
  it { should have_many :items }
  it { should have_many(:products).through(:items) }

  describe "order" do

    let(:item)  { Item.make! }
    let(:order) { item.order }

    describe 'get_balance' do
      it "should ge balance with shipping rate" do
        order.get_balance.should eq 200
      end
    end

    describe 'self.cart_by token' do
      before :all do
        @order = Order.make!(token: '12321kjljo')
      end

      it "should update create_at if cart present " do
        Order.cart_by('12321kjljo').should_not be_nil
      end

      it "should equal cart " do
        Order.cart_by('12321kjljo').should eq @order
      end
    end

    describe "calculate_items" do
      it "should calculate items" do
        order.calculate_items.should be_true
        order.items_count.should eq 1
        order.total.should eq 100
      end
    end

    describe "calculate_balance" do
      it "should calculate balance" do
        order.calculate_balance.should be_true
        order.balance.should eq 200
      end
    end
  end
end