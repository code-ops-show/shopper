class CreateShipingRate < ActiveRecord::Migration
  def change
    create_table :shipping_rates do |t|
      t.string :name
      t.integer :rate

      t.timestamps
    end
  end
end
