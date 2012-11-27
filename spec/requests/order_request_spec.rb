require 'spec_helper'

describe "OrderRequest" do

  let!(:category)  { Category.make! }

  describe "category index", js: true do
    it "should show all category" do
      visit categories_path
      page.should have_content("All Categories")
      puts category.name
      page.should have_link(category.name)
    end
  end

  describe "category/product index", js: true do
    it "should show all product" do
      visit categories_path
      page.should have_content("All Categories")
      page.should have_link(category.name)
      click_link category.name
    end
  end
end