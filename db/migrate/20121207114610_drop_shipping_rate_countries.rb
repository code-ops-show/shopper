class DropShippingRateCountries < ActiveRecord::Migration
  def change
    drop_table :countries_shipping_rates
  end
end
