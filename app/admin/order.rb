ActiveAdmin.register Order do
  config.per_page = 20
  scope :only_completed, default: true
  scope :only_cart
  scope :only_shipping
  scope :only_cancel

  index do
    column "User email" do |order|
      order.address.email rescue ""
    end
    column "Address" do |order|
      order.address
    end
    column("Status") do |order|
      case order.state
        when "cart"      then status_tag(order.state)
        when "purchased" then status_tag(order.state, :ok)
        when "canceled"  then status_tag(order.state, :error)
        when "shipped"  then status_tag(order.state, :ok)
      end
    end
    column("Balance") do |order|
      order.balance
    end
    default_actions
  end

  form partial: 'form'
end