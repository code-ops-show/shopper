class Order
  module Stateful
    extend ActiveSupport::Concern

    included do 
      scope :open_orders, -> { with_state(:cart) }

      state_machine initial: :cart do
        before_transition from: :cart,      to: :purchased, do: :validates_cart
        before_transition from: :cart,      to: :purchased, do: :validates_assign_email
        after_transition  from: :cart,      to: :purchased, do: :set_default_address
        after_transition  from: :cart,      to: :purchased, do: :consolidate_stock
        after_transition  from: :cart,      to: :purchased, do: :send_mail
        after_transition  from: :purchased, to: :canceled,  do: :return_stock
        after_transition  from: :purchased, to: :canceled,  do: :send_mail
        after_transition  from: :purchased, to: :shipped,   do: :send_mail

        event :purchase do
          transition from: :cart, to: :purchased
        end

        event :cancel do
          transition from: :purchased, to: :canceled
        end

        event :ship do
          transition from: :purchased, to: :shipped
        end
      end
    end

    def validates_cart
      address_id.present? and items.present?
    end

    def validates_assign_email
      user = address.user
      @user_exists = user_exists

      if @user_exists and @user_exists.member?
        errors.add(:guest_email, "Please sign in. This email had already been member.") 
      elsif not @user_exists and user.guest?
        errors.add(:guest_email, "Please enter email address.") if guest_email.blank?
        user.update_attributes(email: guest_email)
      end
    end

    def set_default_address
      user = address.user
      
      if @user_exists and @user_exists.guest?
        user.move_to(@user_exists)
        @user_exists.set_default_to(address)
        user = @user_exists
      elsif user.guest? or user.member?
        user.set_default_to(address)
      end
    end

    def consolidate_stock
      items.each { |item| item.consolidate_stock }
      calculate_balance
    end

    def return_stock
      items.each { |item| item.return_stock }
    end

    def send_mail
      case state
        when 'purchased' then OrderMailer.delay.purchased_state(self)
        when 'canceled'  then OrderMailer.delay.canceled_state(self)
        when 'shipped'   then OrderMailer.delay.shipped_state(self)
      end
    end

    private
    def user_exists
      @user_exists ||= User.find_by_email(guest_email)
    end
  end
end