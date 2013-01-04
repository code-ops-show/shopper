require 'spec_helper'

describe "Orders Requests" do
  let(:order)   { Order.make! }
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