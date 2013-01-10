require 'spec_helper'

feature "Addresses Requests" do
  given(:address)  { Address.make! }
  given(:user)     { address.user }
  given(:country)  { address.country }

  background do 
    login user
    visit edit_user_registration_path
  end

  scenario "should create new address", js: true do
    within_fieldset "addresses" do
      page.find(:css, "a.add").click
    end
    
    within "#modal" do
      fill_in "address_street_address", with: "street 001"
      fill_in "address_city", with: "city 001"
      fill_in "address_state", with: "state 001"
      fill_in "address_zip", with: "001"
      select  "#{country.name}", from: "address_country_id"
      fill_in "address_phone", with: "001"
      click_button "Save"
    end

    within_fieldset "addresses" do
      page.should have_content "street 001 / #{country.name}"
    end
  end

  scenario "should edit address", js: true do
    within "#address_#{address.id}" do
      page.find(:css, "a.edit").click
    end
    
    within "#modal" do
      fill_in "address_street_address", with: "edit street 002"
      fill_in "address_city", with: "edit city 002"
      fill_in "address_state", with: "edit state 002"
      fill_in "address_zip", with: "002"
      select  "#{country.name}", from: "address_country_id"
      fill_in "address_phone", with: "002"
      click_button "Save"
    end

    within_fieldset "addresses" do
      page.should have_content "edit street 002 / #{country.name}"
    end
  end

  scenario "should remove address", js: true do
    within "#address_#{address.id}" do
      page.find(:css, "a.remove").click
    end
    page.driver.browser.switch_to.alert.accept

    page.should_not have_content address.street_address
    page.should_not have_content address.country.name
  end

  context "set default" do
    scenario "should have address default" do
      page.should have_css "#address_#{address.id}.success"
    end

    scenario "should unset/set address's default", js: true do
      within "#address_#{address.id}" do
        page.find(:css, "a.default").click
      end
      page.should_not have_css "#address_#{address.id}.success"

      within "#address_#{address.id}" do
        page.find(:css, "a.default").click
      end
      page.should have_css "#address_#{address.id}.success"
    end
  end
end