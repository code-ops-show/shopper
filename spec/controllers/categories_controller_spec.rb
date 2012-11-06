require 'spec_helper'

describe CategoriesController do

  let(:categories) { Categories.make! }

  describe "GET 'index'" do
    it "return http success" do
      get :index
      response.should be_success
    end

    it "should assign the all product to the view" do
      get :index
      assigns[:categories].should_not be_nil
    end

    it "should assign the all product to the view" do
      get :index
      assigns[:categories].should eq Category.all
    end
  end
end