require 'spec_helper'

describe Item do
  it { should belong_to :product }
  it { should belong_to :order }

  describe "Model setup and utilities" do
    let(:item)     { Item.make! }
    let(:product)  { item.product }
    let(:order)    { item.order }

    it "should return calculate total price" do
      item.calculate_total.should eq(product.price)
    end

    describe "increment_quantity" do
      it "should increment quantity" do
        item.increment_quantity.should eq 1
      end
    end

    describe "touch_order" do
      it "should touch order" do
        item.update_attributes(quantity: 5)
        item.save
        item.touch_order
        order.items_count.should eq 5
        order.total.should eq 500
      end
    end

    describe "consolidate_stock" do
      it "should consolidate stock" do
        item.consolidate_stock
        product.quantity.should eq 9
      end
    end

    describe "return_stock" do
      it "should return stock" do
        item.return_stock.should be_true
        product.quantity.should eq 11
      end
    end

    context "update" do 
      it "should not be valid on update" do 
        expect { 
          item.update_attributes!(new_quantity: 10, increment: true)
        }.to raise_error ActiveRecord::RecordInvalid
      end

      it "should be valid on update" do 
        expect { 
          item.update_attributes!(new_quantity: 9, increment: true)
        }.to change{item.quantity}.to(10)
      end
    end

    context 'create' do 
      let(:order) { Order.make! }
      it "should be valid on create" do 
        item = product.items.build(quantity: 1)
        item.should be_valid
      end
    end
  end
end