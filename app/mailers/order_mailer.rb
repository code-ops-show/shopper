class OrderMailer < ActionMailer::Base
  default from: "shopper@example.com"

  def purchased_state(order)
    @order = order
    mail to: order.address.email, subject: "Order purchased"
  end

  def shipped_state(order)
    @order = order
    mail to: order.address.email, subject: "Order shipped"
  end

  def canceled_state(order)
    @order = order
    mail to: order.address.email, subject: "Order canceled"
  end
end
