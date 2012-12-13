require 'spec_helper'

describe Item do
  it { should belong_to :product }
  it { should belong_to :order }

  describe "Model setup and utilities" do
    let(:item)     { Item.make! }
    let(:product)  { item.product }
    let(:order)    { item.order }

    it "should return unit price" do
      item.unit_price.should eq(product.price)
    end

    it "should return full price" do
      item.full_price.should eq(1000)
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