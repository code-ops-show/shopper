# encoding: utf-8

require 'spec_helper'

describe OrderPdf do
  let!(:item)               { Item.make! }
  let!(:order)              { item.order }
  let!(:address)            { order.address }
  let!(:user)               { address.user }

  before { @order_pdf = PDF::Reader.new(StringIO.new(OrderPdf.new(order, view).render))}

  it "should render the artellectual address" do
    @order_pdf.page(1).text.should include("Artellectual Co., Ltd., 5/37 Sukhumvit 71")
  end

  it "should render the invoice number" do
    @order_pdf.page(1).text.should include("Invoice No. ##{order.id}")
  end

  it "should render the shipping and billing to" do
    @order_pdf.page(1).text.should include("Shipping & Billing to:")
  end

  it "should render the item head" do
    @order_pdf.page(1).text.should include("Product name", "Unit Price", "Quantity", "Full Price")
  end
end