require "spec_helper"

describe OrderMailer do
  describe "purchased_state," do
    let(:mail) { OrderMailer.purchased_state }

    it "renders the headers" do
      mail.subject.should eq("Purchased state")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

  describe "shipped_state" do
    let(:mail) { OrderMailer.shipped_state }

    it "renders the headers" do
      mail.subject.should eq("Shipped state")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
