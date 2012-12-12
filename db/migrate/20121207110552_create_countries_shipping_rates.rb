class CreateCountriesShippingRates < ActiveRecord::Migration
  def change
    create_table :countries_shipping_rates do |t|
      t.integer :country_id
      t.integer :shipping_rate_id

      t.timestamps
    end
  end
end
