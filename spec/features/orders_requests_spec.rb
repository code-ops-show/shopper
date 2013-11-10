require 'spec_helper'

feature "Orders Requests" do
  context "orders history" do
    given(:item)    { Item.make! }
    given(:order)   { item.order }
    given(:address) { order.address }
    given(:user)    { address.user }
    given(:country) { address.country }

    background do
      login user
      visit user_orders_path(user)
    end

    scenario "should show order" do
      within "#order_#{order.id}" do
        page.should have_content "Invoice No. ##{order.id}"
        page.should have_content address.street_address
      end
    end
  end

  context "purchased", js: true do
    given(:guest)   { Guest.make! }
    given(:item)    { Item.make!(:no_user) }
    given(:order)   { item.order }
    given(:address) { order.address }

    background do
      ApplicationController.any_instance.stub(:current_order).and_return(order)
      visit root_path
      click_link "Cart"

      within "#view_cart" do
        click_link "Check Out"
      end

      ApplicationController.any_instance.stub(:guest_user).and_return(guest)
      order.address.update_attributes(user_id: guest.id)
      click_link "Continue as a Guest"

      within "#current-total" do
        click_button "Purchase"
      end

      within "#purchase" do
        fill_in "order_guest_email", with: "guest_new@guest.com"
        click_button "Confirm"
      end
    end

    scenario "should show 'Print Invoice' button path correctly" do
      page.should have_link "Print Invoice", href: order_path(order, format: "pdf")
    end

    scenario "should typing password for create account" do
      fill_in "guest_password", with: "123456"
      fill_in "guest_password_confirmation", with: "123456"
      click_button "Create Account"

      page.should have_content "Welcome! You have created account successfully."
      page.should have_content "Guest new"
    end
  end
end