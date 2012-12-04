require 'spec_helper'

describe Product do
  it { should have_many :items }
  it { should have_many(:orders).through(:items) }
  it { should belong_to :category }

  describe "Model setup and utilities" do
    it "should have scope for last four products" do
      products = []
      5.times { products.push Product.make! }

      products.length.should eq(5)
      Product.last_four_products.length.should eq(4)
    end
  end
end