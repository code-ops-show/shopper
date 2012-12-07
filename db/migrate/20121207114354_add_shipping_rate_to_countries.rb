class AddShippingRateToCountries < ActiveRecord::Migration
  def change
    add_column :countries, :shipping_rate_id, :integer
  end
end
