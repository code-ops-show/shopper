require "spec_helper"
include ApplicationHelper

describe OrderMailer do

  let(:order)       { Order.make! }
  let(:item)        { order.items.make! }

  describe "purchased_state," do
    let(:mail) { OrderMailer.purchased_state(order) }

    it_should_behave_like "renders the headers"

    it "renders the body" do
      mail.body.encoded.should include 'Thank you for your purchase :)'
    end
  end

  describe "shipped_state" do
    let(:mail) { OrderMailer.shipped_state(order) }

    it_should_behave_like "renders the headers"

    it "renders the body" do
      mail.body.encoded.should include 'Your purchase order shipped'
    end
  end

  describe "canceled_state" do
    let(:mail) { OrderMailer.canceled_state(order) }

    it_should_behave_like "renders the headers"

    it "renders the body" do
      mail.body.encoded.should include 'Your purchase order canceled'
    end
  end
end
