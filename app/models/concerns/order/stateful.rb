class Order
  module Stateful
    extend ActiveSupport::Concern

    included do 
      scope :open_orders, -> { with_state(:cart) }

      state_machine initial: :cart do
        before_transition cart: :purchased, do: :validates_cart
        before_transition cart: :purchased, do: :validate_and_set_default
        after_transition  cart: :purchased, do: :set_default_address

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

      def validates_cart
        address_id.present? and items.present?
      end

      def set_default_address
        address.user.set_default_to address if address.user.member?
      end

      def validate_and_set_default
        user = address.user
        user_exists = User.find_by_email(guest_email)

        if user_exists and user_exists.guest?
          user.move_to(user_exists)
          user_exists.set_default_to(address)
          address.user = user_exists
        else
          user.email = guest_email
          errors.add(:guest_email, "Please sign in. This email had already been member.") if user_exists and user_exists.member?
          errors.add(:guest_email, "Please enter email address.") unless user.save
        end
      end
    end
  end
end