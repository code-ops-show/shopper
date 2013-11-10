require 'spec_helper'

feature "Carts Requests" do
  context "guest without address", js: true do
    given(:guest)    { Guest.make! }
    given(:item)     { Item.make!(:only) }
    given(:order)    { item.order }
    given!(:country) { Country.make! }

    background do
      ApplicationController.any_instance.stub(:current_order).and_return(order)
      visit root_path
      click_link "Cart"

      within "#view_cart" do
        click_link "Check Out"
      end

      ApplicationController.any_instance.stub(:guest_user).and_return(guest)
      click_link "Continue as a Guest"
    end

    scenario "should fail when purchase" do
      click_button "Purchase"
      page.should have_content "Please choose shipping address."
    end

    scenario "should choose new first address" do
      click_link "New Address"

      within "#modal" do
        fill_in "address_street_address", with: "cart street 001"
        fill_in "address_city", with: "cart city 001"
        fill_in "address_state", with: "cart state 001"
        fill_in "address_zip", with: "001"
        select  "#{country.name}", from: "address_country_id"
        fill_in "address_phone", with: "001"
        click_button "Save"
      end

      address = guest.addresses.reload.last

      sleep 2
      within "#current-total td.shipping-rate.price" do
        page.should have_content "100.00"
        page.should_not have_content "not calculated"
      end
      page.should have_css "#address_#{address.id} input[checked]"
    end
  end

  context "guest", js: true do
    given(:guest)   { Guest.make! }
    given(:member)  { Member.make! }
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
    end

    scenario "should fill email before confirm purchase" do
      within "#current-total" do
        click_button "Purchase"
      end

      within "#purchase" do
        fill_in "order_guest_email", with: "guest_new@guest.com"
        click_button "Confirm"
      end

      page.should have_content "Invoice No. ##{order.id}"
      page.should have_content "Print Invoice"
      page.should have_button "Create Account"
    end

    scenario "should confirm purchase pass when guest's email exists" do
      within "#current-total" do
        click_button "Purchase"
      end

      within "#purchase" do
        fill_in "order_guest_email", with: member.email
        click_button "Confirm"
      end

      page.should have_content "Please sign in. This email had already been member."
    end

    scenario "should confirm purchase fail when member's exists" do
      within "#current-total" do
        click_button "Purchase"
      end

      within "#purchase" do
        fill_in "order_guest_email", with: "guest_exists@guest.com"
        click_button "Confirm"
      end

      page.should have_content "Invoice No. ##{order.id}"
      page.should have_content "Print Invoice"
      page.should have_button "Create Account"
    end

    scenario "should confirm purchase fail when don't fill email" do
      within "#current-total" do
        click_button "Purchase"
      end

      within "#purchase" do
        fill_in "order_guest_email", with: ""
        click_button "Confirm"
      end

      page.should have_content "Please enter email address."
    end
  end

  context "member" do
    given(:item)           { Item.make!(:member) }
    given(:order)          { item.order }
    given(:product)        { item.product }
    given(:address)        { order.address }
    given(:user)           { address.user }
    given(:country)        { address.country }

    given(:address2)       { user.addresses.make! }
    given(:country2)       { address2.country }
    given(:shipping_rate2) { country2.shipping_rate }

    background do
      ApplicationController.any_instance.stub(:current_order).and_return(order)
      shipping_rate2.update_attributes(rate: 200)

      login user
      click_link "Cart"
    end

    context "#modal", js: true do
      background do
      end

      scenario "should change quantity item" do
        within "#item_#{item.id}" do
          page.find(:css, "input[name$='[quantity]']").set(5)
        end

        sleep 1
        within "#item_#{item.id}" do
          page.should have_content "500.00"
        end
      end

      scenario "should remove item" do
        within "#item_#{item.id}" do
          page.find(:css, "a.remove").click
        end
        page.driver.browser.switch_to.alert.accept
        page.should_not have_css "#item_#{item.id}"
      end
    end

    context "#checkout", js: true do
      background do
        within "#view_cart" do
          click_link "Check Out"
        end
      end

      context "items" do
        background do 
        end

        scenario "should change quantity item" do
          within "#item_#{item.id}" do
            page.find(:css, "input[name$='[quantity]']").set(6)
          end

          sleep 1
          within "#item_#{item.id}" do
            page.should have_content "600.00"
          end
        end

        scenario "should remove item" do
          within "#item_#{item.id}" do
            page.find(:css, "a.remove").click
          end
          page.driver.browser.switch_to.alert.accept
          page.should_not have_css "#item_#{item.id}"
        end
      end

      context "shipping address" do
        scenario "should choose default address" do
          page.should have_css "#address_#{address.id} input[checked]"
        end

        scenario "should new address and select" do
          click_link "New Address"
          
          within "#modal" do
            fill_in "address_street_address", with: "cart 001 street"
            fill_in "address_city",           with: "cart 001 city"
            fill_in "address_state",          with: "cart 001 state"
            fill_in "address_zip",            with: "cart 001 zip"
            select "#{country.name}",         from: "address_country_id"
            fill_in "address_phone",          with: "cart 001 phone"
            click_button "Save"
          end
          page.should have_content "cart 001 street"
          page.should have_content "#{country.name}"
        end

        scenario "should shipping rate changed when choose address (another country)" do
          page.find(:css, "#address_#{address2.id}").click

          sleep 1
          within "#current-total td.shipping-rate.price" do
            page.should have_content "200.00"
          end
        end
      end

      scenario "should confirm purchase" do
        within "#current-total" do
          click_button "Purchase"
        end

        within "#purchase" do
          click_button "Confirm"
        end

        page.should have_content "Invoice No. ##{order.id}"
        page.should have_content "Print Invoice"
        page.should_not have_content "Create Account"
      end
    end
  end
end