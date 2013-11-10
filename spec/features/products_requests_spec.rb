require 'spec_helper'

feature "Products Requests" do
  given(:member) { Member.make! }
  given(:order)  { Order.make! }

  background :all do
    Product.destroy_all
    Category.destroy_all

    @product = Product.make!(name: "ant product", price: 90)
    @product2 = Product.make!(name: "bird product", price: 180)
    @product3 = Product.make!(name: "zebra product", price: 270, quantity: 0)
    @category = @product.category
    @category2 = @product2.category
  end

  background { login member }

  context "#index" do
    background { visit products_path }

    scenario "should view products by category" do
      click_link @category.name
      page.should have_content "ant product"
      page.should_not have_content "bird product"

      click_link @category2.name
      page.should_not have_content "ant product"
      page.should have_content "bird product"
    end

    scenario "should add product to cart", js: true do
      within "#product_#{@product.id}" do
        click_button "Add Cart"
      end
      page.should have_content "Cart (1)"
    end

    scenario "should show out of stock when available" do
      within "#product_#{@product3.id}" do
        page.should have_content "Out of Stock"
        page.should_not have_content "Add to Cart"
      end
    end

    context "filter" do
      scenario "should display by price range" do
        within "div.price" do
          fill_in "min", with: 0
          fill_in "max", with: 100
          click_button "View"
        end

        page.should have_content "ant product"
        page.should_not have_content "bird product"
        page.should_not have_content "zebra product"
      end

      scenario "should search product by keyword" do
        fill_in "query", with: "bird product"
        click_button "Search"

        page.should_not have_content "ant product"
        page.should have_content "bird product"
        page.should_not have_content "zebra product"
      end
    end

    context "sorting", js: true do
      scenario "should sorting by name A-Z" do
        select "Name: A-Z", from: 'sort_by'

        within "ul.thumbnails li:first-child" do page.should have_content "ant product" end
        within "ul.thumbnails li:last-child"  do page.should have_content "zebra product" end
      end

      scenario "should sorting by name Z-A" do
        select "Name: Z-A", from: 'sort_by'

        within "ul.thumbnails li:first-child" do page.should have_content "zebra product" end
        within "ul.thumbnails li:last-child"  do page.should have_content "ant product" end
      end

      scenario "should sorting by Price: Low to High" do
        select "Price: Low to High", from: 'sort_by'

        within "ul.thumbnails li:first-child" do page.should have_content "ant product" end
        within "ul.thumbnails li:last-child"  do page.should have_content "zebra product" end
      end

      scenario "should sorting by Price: High to Low" do
        select "Price: High to Low", from: 'sort_by'

        within "ul.thumbnails li:first-child" do page.should have_content "zebra product" end
        within "ul.thumbnails li:last-child"  do page.should have_content "ant product" end
      end
    end
  end

  context "#show" do
    scenario "should add product to cart", js: true do
      within "#product_#{@product.id}" do
        click_link "ant product"
      end

      click_button "Add Cart"
      page.should have_content "Cart (1)"
    end

    scenario "should show out of stock when unavailable" do
      within "#product_#{@product3.id}" do
        click_link "zebra product"
      end

      page.should have_content "Out of Stock"
      page.should_not have_content "Add to Cart"
    end
  end
end