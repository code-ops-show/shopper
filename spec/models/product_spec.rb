require 'spec_helper'

describe Product do
  it { should have_many :items }
  it { should have_many(:orders).through(:items) }
  it { should belong_to :category }

  describe "Model setup and utilities" do

    let!(:product)       { Product.make! }
    let(:category)      { product category }

    it "should have scope for last four products" do
      products = []
      5.times { products.push Product.make! }

      products.length.should eq 5
      Product.last_four_products.length.should eq 4
    end

    it "should show only quantity more than 0" do
      Product.make!(quantity: 0)
      Product.available.length.should eq 2
    end

    describe "self.text_search(query)" do
      it "should return search query" do
        Product.text_search(product.name).first.should eq product
      end

      it "should return scoped if no query" do
        Product.text_search('').should eq Product.all
      end
    end

    describe "self.by_category(category_id)" do
      # it "should return product by category" do
      #   Product.by_category(category.id).first.should eq product
      # end

      it "should return scoped if no product price in rang" do
        Product.by_category('').should eq Product.all
      end
    end

    describe "self.by_price_range(min, max)" do
      it "should return product by pricerange" do
        Product.by_price_range(50, 200).size.should eq 2
      end

      it "should return nil if no product price in rang" do
        Product.by_price_range(0, 1).first.should be_nil
      end

      it "should return scoped if no product price in rang" do
        Product.by_price_range('',nil).should eq Product.all
      end
    end
  end
end