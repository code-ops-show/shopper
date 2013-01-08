require 'spec_helper'

describe ProductsController do

  let!(:product)     { Product.make! }
  let(:category)    { product.category }

  describe "GET 'index'" do
    it "return http success" do
      get :index
      response.should be_success
    end

    it "should assign product not nil" do
      get :index
      assigns[:products].should_not be_nil
    end

    it "should assign the all product to the view" do
      get :index
      assigns[:products].should eq Product.all
    end

    it "should assign the all product to the view by category" do
      get :index, category_id: category.slug
      assigns[:products].size.should eq category.products.size
    end

    it "should assign the all product to the view by text search" do
      get :index, query: product.name
      assigns[:products].first.name.should eq product.name
    end

    it "should assign the all product to the view by price range" do
      get :index, min: 50, max: 200
      assigns[:products].last.should eq product
    end
  end

  describe "GET 'show'" do
    it "return http success" do
      get :show, id: product.id
      response.should be_success
    end

    it "should assign the all product to the view" do
      get :show, id: product.id
      assigns[:product].should_not be_nil
    end

    it "should assign the all product to the view" do
      get :show, id: product.id
      assigns[:product].should eq product
    end
  end
end