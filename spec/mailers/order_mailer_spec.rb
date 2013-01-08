require "spec_helper"

describe OrderMailer do
  
  let(:order)       { Order.make! }
  let!(:address)    { order.address }
  let(:user)        { address.user }

  describe "purchased_state," do
    let(:mail) { OrderMailer.purchased_state(order) }

    it "renders the headers" do
      mail.subject.should eq("Order purchased")
      mail.to.should eq([order.address.email])
      mail.from.should eq(["shopper@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should include 'status: purchased'
    end
  end

  describe "shipped_state" do
    let(:mail) { OrderMailer.shipped_state(order) }

    it "renders the headers" do
      mail.subject.should eq("Order shipped")
      mail.to.should eq([order.address.email])
      mail.from.should eq(["shopper@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should include 'status: shipped'
    end
  end

  describe "canceled_state" do
    let(:mail) { OrderMailer.canceled_state(order) }

    it "renders the headers" do
      mail.subject.should eq("Order canceled")
      mail.to.should eq([order.address.email])
      mail.from.should eq(["shopper@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should include 'status: canceled'
    end
  end
end
