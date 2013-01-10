require 'spec_helper'

describe Product do
  it { should have_many :items }
  it { should have_many(:orders).through(:items) }
  it { should belong_to :category }

  describe "Model setup and utilities" do

    let!(:product)        { Product.make! }
    let(:category)        { product.category }

    it "should have scope for last four products" do
      products = []
      5.times { products.push Product.make! }

      products.length.should eq 5
      Product.last_four_products.length.should eq 4
    end

    it "should show only quantity more than 0" do
      Product.make!(quantity: 0)
      Product.available.last.should eq product
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
      it "should return product by category" do
        Product.by_category(category.slug).first.should eq product
      end

      it "should return scoped if no product price in rang" do
        Product.by_category('').should eq Product.all
      end
    end

    describe "self.by_price_range(min, max)" do
      it "should return product by pricerange" do
        Product.by_price_range(50, 200).last.should eq product
      end

      it "should return nil if no product price in rang" do
        Product.by_price_range(0, 1).first.should be_nil
      end

      it "should return scoped if no product price in rang" do
        Product.by_price_range('', nil).should eq Product.all
      end
    end

    describe "self.sort_by(type)" do

      before :all do
        Product.destroy_all
        Category.destroy_all

        Product.make!(name: 'Ant', price: 1000)
        Product.make!(name: 'zebra', price: 2000)
        Product.make!(name: 'highest-price', price: 6000)
        Product.make!(name: 'lowest-price', price: 10)
      end

      it "should return name by ASC" do
        Product.sort_by(1).first.name.should eq 'Ant'
      end

      it "should return name by DESC" do
        Product.sort_by(2).first.name.should eq 'zebra'
      end

      it "should return price by ASC" do
        Product.sort_by(3).first.name.should eq 'lowest-price'
      end

      it "should return price by DESC" do
        Product.sort_by(4).first.name.should eq 'highest-price'
      end

      it "should return price by DESC" do
        Product.sort_by(5).should eq Product.all
      end
    end
  end
end