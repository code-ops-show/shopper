class Order
  module Stateful
    extend ActiveSupport::Concern

    included do 
      scope :open_orders, -> { with_state(:cart) }

      state_machine initial: :cart do
        before_transition cart: :purchased, do: :validates_cart
        after_transition  cart: :purchased, do: :set_default_address

        event :purchase do
          transition from: :cart, to: :purchased
        end

        event :cancel do
          transition from: :purchased, to: :canceled
        end

        event :resume do
          transition from: :canceled, to: :purchased
        end

        event :ship do
          transition from: :purchased, to: :shipped
        end

        state :purchase do 
          validate :check_email
        end
      end

      def validates_cart
        address_id.present? and items.present?
      end

      def set_default_address
        unless guest_email
          user = address.user
          user.addresses.default.update_all(default: false)
          address.update_attribute :default, true
        end
      end

      def check_email
        errors.add(:guest_email, "No Email Available") if guest_email.match(/^guest_\d*@example.com/)
      end
    end
  end
end