require 'spec_helper'

describe "Orders Requests" do
  context "orders history" do
    let(:item)    { Item.make! }
    let(:order)   { item.order }
    let(:address) { order.address }
    let(:user)    { address.user }
    let(:country) { address.country }

    before do
      login user
      visit user_orders_path(user)
    end

    it "should show order" do
      within "#order_#{order.id}" do
        page.should have_content "Invoice No. ##{order.id}"
        page.should have_content address.street_address
      end
    end
  end

  context "purchased", js: true do
    let(:guest)   { User.make!(:guest) }
    let(:item)    { Item.make!(:no_user) }
    let(:order)   { item.order }
    let(:address) { order.address }

    before do
      ApplicationController.any_instance.stub(:current_order).and_return(order)
      visit root_path
      click_link "Cart"

      wait_until(10) { page.find(:css, "#view_cart").visible? }
      within "#view_cart" do
        click_link "Check Out"
      end

      ApplicationController.any_instance.stub(:guest_user).and_return(guest)
      order.address.update_attributes(user_id: guest.id)
      click_link "Continue as a Guest"

      within "#current-total" do
        click_button "Purchase"
      end

      wait_until(10) { page.find(:css, "#purchase").visible? }
      within "#purchase" do
        fill_in "order_guest_email", with: "guest_new@guest.com"
        click_button "Confirm"
      end
    end

    it "should show 'Print Invoice' button path correctly" do
      page.should have_link "Print Invoice", href: order_path(order, format: "pdf")
    end

    it "should typing password for create account" do
      fill_in "guest_password", with: "123456"
      fill_in "guest_password_confirmation", with: "123456"
      click_button "Create Account"

      page.should have_content "Welcome! You have created account successfully."
      page.should have_content "Guest new"
    end
  end
end