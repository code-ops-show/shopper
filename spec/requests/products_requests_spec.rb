require 'spec_helper'

describe "Products Requests" do
  let(:member) { User.make!(:member) }
  let(:order)  { Order.make! }

  before :all do
    @product = Product.make!(name: "Product 001", price: 100)
    @product2 = Product.make!(name: "Product 002", price: 200)
    @product3 = Product.make!(name: "Product 003", price: 300, quantity: 0)
    @category = @product.category
    @category2 = @product2.category
  end

  before { login member }

  context "#index" do
    before { visit products_path }

    it "should view products by category" do
      click_link @category.name
      page.should have_content "Product 001"
      page.should_not have_content "Product 002"

      click_link @category2.name
      page.should_not have_content "Product 001"
      page.should have_content "Product 002"
    end

    it "should add product to cart", js: true do
      within "#product_#{@product.id}" do
        click_button "Add Cart"
      end
      page.should have_content "Cart (1)"
    end

    it "should show out of stock when available" do
      within "#product_#{@product3.id}" do
        page.should have_content "Out of Stock"
        page.should_not have_content "Add to Cart"
      end
    end

    context "filter" do
      it "should display by price range" do
        within "div.price" do
          fill_in "min", with: 0
          fill_in "max", with: 100
          click_button "View"
        end

        page.should have_content "Product 001"
        page.should_not have_content "Product 002"
        page.should_not have_content "Product 003"
      end

      it "should search product by keyword" do
        fill_in "query", with: "Product 001"
        click_button "Search"

        page.should have_content "Product 001"
        page.should_not have_content "Product 002"
        page.should_not have_content "Product 003"
      end
    end

    context "sorting", js: true do
      it "should sorting by name A-Z" do
        select "Name: A-Z", from: 'sort_by'

        within "ul.thumbnails li:first-child" do page.should have_content "Product 001" end
        within "ul.thumbnails li:last-child"  do page.should have_content "Product 003" end
      end

      it "should sorting by name Z-A" do
        select "Name: Z-A", from: 'sort_by'

        within "ul.thumbnails li:first-child" do page.should have_content "Product 003" end
        within "ul.thumbnails li:last-child"  do page.should have_content "Product 001" end
      end

      it "should sorting by Price: Low to High" do
        select "Price: Low to High", from: 'sort_by'

        within "ul.thumbnails li:first-child" do page.should have_content "Product 001" end
        within "ul.thumbnails li:last-child"  do page.should have_content "Product 003" end
      end

      it "should sorting by Price: High to Low" do
        select "Price: High to Low", from: 'sort_by'

        within "ul.thumbnails li:first-child" do page.should have_content "Product 003" end
        within "ul.thumbnails li:last-child"  do page.should have_content "Product 001" end
      end
    end
  end

  context "#show" do
    it "should add product to cart", js: true do
      within "#product_#{@product.id}" do
        click_link "Product 001"
      end

      click_button "Add Cart"
      page.should have_content "Cart (1)"
    end

    it "should show out of stock when unavailable" do
      within "#product_#{@product3.id}" do
        click_link "Product 003"
      end

      page.should have_content "Out of Stock"
      page.should_not have_content "Add to Cart"
    end
  end
end