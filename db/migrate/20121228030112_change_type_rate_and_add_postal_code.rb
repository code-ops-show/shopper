class ChangeTypeRateAndAddPostalCode < ActiveRecord::Migration
  def change
    change_column :shipping_rates, :rate, :float, default: 0
    add_column    :addresses, :postal_code, :integer, default: 0
  end
end
