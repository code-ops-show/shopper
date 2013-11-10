shared_examples_for "renders the headers" do
  let(:order)       { Order.make! }
  let!(:address)    { order.address }

  it "renders the headers" do
    mail.subject.should eq("Order #{order.state.humanize} / Invoice No. ##{order.id}")
    mail.to.should eq([order.address.email])
    mail.from.should eq(["shopper@example.com"])
  end
end