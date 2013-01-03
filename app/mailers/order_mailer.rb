class OrderMailer < ActionMailer::Base
  default from: "shopper@example.com"

  def purchased_state(order)
    @order = order
    attached = OrderPdf.new(order, view_context).render
    attachments["order_#{order.id}.pdf"] = attached

    send_email(order)
  end

  def shipped_state(order)
    @order = order
    send_email(order)
  end

  def canceled_state(order)
    @order = order
    send_email(order)
  end

private
  def send_email(order)
    mail to: order.address.email, subject: "Order #{order.state.humanize} / Invoice No. ##{order.id}" do |format|
      format.html
      format.text
    end
  end
end
