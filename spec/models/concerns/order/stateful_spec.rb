require 'spec_helper'

describe 'Stateful' do
  describe "stateful" do
    before :all do
      @order = Order.make!(token: '12321kjl4')
      @order.items.make!
    end

    let(:member)   { Member.make!(email: 'member@test.com') }
    let!(:guest)   { Guest.make! }
    let!(:address) { guest.addresses.make! }
    let!(:order)   { address.orders.make! }
    let!(:item)    { order.items.make! }
    let!(:product) { item.product }

    before :each do
      order.reload
    end

    describe 'state_machine' do
      it "should be an initial state" do
        @order.cart?.should be_true
      end

      it "should change to :cart on :purchased" do
        @order.reload
        @order.purchase!
        @order.purchased?.should be_true
      end

      it "should change to :purchased on :canceled" do
        @order.cancel!
        @order.canceled?.should be_true
      end
      
      it "should change to :purchased on :shipped" do
        @order.update_attributes(state: 'purchased')
        @order.save
        @order.ship!
        @order.shipped?.should be_true
      end
    end

    describe "validates_cart" do
      it "should have addresses and items" do
        order.validates_cart
        order.address.should_not be_nil
        order.items.should_not be_nil
      end
    end

    describe "validates_assign_email" do
      it "should validates assign email if user had exists and type member" do
        order.guest_email = member.email
        order.validates_assign_email
        order.errors.messages[:guest_email].should == ["Please sign in. This email had already been member."]
      end

      it "should validates assign email if guest user don't exists and guest email is blank" do
        order.validates_assign_email
        order.errors.messages[:guest_email].should == ["Please enter email address."]
      end

      it "should validates assign email if guest user don't exists" do
        order.guest_email = 'bot@test.com'
        order.validates_assign_email

        order.errors.messages.should be_blank
        order.address.email.should eq 'bot@test.com'
      end
    end

    describe "set_default_address" do
      it "should set default address if user type member" do
        member  = Member.make!(email: 'test@test.com')
        address = member.addresses.make!
        order   = address.orders.make!

        order.set_default_address
        order.address.user.should eq member
      end

      it "should set default address if guest user exists" do
        order.guest_email = guest.email
        order.set_default_address
        order.address.user.should eq guest
      end
    end

    describe "consolidate_stock" do
      it "should consolidate stock when purchase" do
        order.consolidate_stock
        product.reload
        product.quantity.should eq 9
      end
    end

    describe "return_stock" do
      it "should return stock when order has canceled" do
        order.return_stock
        product.reload
        product.quantity.should eq 11
      end
    end
  end
end