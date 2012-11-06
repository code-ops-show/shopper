require 'spec_helper'

describe HomeController do

  let(:product) { Product.make! }

  describe "GET 'index'" do
    it "return http success" do
      get :index
      response.should be_success
    end

    it "should assign the all product to the view" do
      get :index
      assigns[:products].should_not be_nil
    end

    it "should assign the all product to the view" do
      get :index
      assigns[:products].should == Product.last_four_products
    end
  end
end